+++
title = "Automated Godot iOS upload"
date = 2022-12-29
updated = 2022-12-30
aliases = ["giu"]
+++

Github Actions allow you to automate repetitive tasks, like exporting your game for iOS and uploading it to the App Store.
It also brings the advantage that you don't need a Mac at all. So it saves you time and money, if you're not a Mac user.  
I'm using the action already in my Godot games like [Pocket Broomball](https://github.com/dulvui/pocket-broomball/blob/main/.github/workflows/upload-ios.yml) or [Ball2Box](https://github.com/dulvui/ball2box/blob/main/.github/workflows/upload-ios.yml).  
You can find the action and instructions on [Github](https://github.com/dulvui/godot-ios-upload).

## How does the action work?
The action uses only macOS built-in command line tools like `xcodebuild` and `xcrun` and has no third party dependencies.
So we can be sure that it always works with the tools Apple itself provides. There are alternatives like [Fastlane](https://fastlane.tools/) that is a powerful tool to make even more things than uploading the app to the App Store. But for this use-case the built-in tools are enough.

First a check is made to see if the action actually runs on a macOS runner, because it wouldn't work on a Linux or Windows runner.
```yml
- name: Check is running on mac-os
    if: runner.os != 'macos'
    shell: bash
    run: exit 1
```

Then a cache is created using the `actions/cache@v3` action. This cache saves the Godot Engine, configurations and export templates in a persistent memory. This saves time and Github's bandwidth. A new cache is created if the `godot-version` of the inputs changes.
```yml
- name: Cache Godot files
    id: cache-godot
    uses: actions/cache@v3
    with:
    path: |
        ~/.local/share/godot/**
        godot
        ~/.config/godot/**
    key: ${{ runner.os }}-godot-${{ inputs.godot-version }}
```


The action uses a headless macOS build you can find on [Github](https://github.com/huskeee/godot-headless-mac).
This build allows the action to run Godot without UI and exporting the game for iOS. So here the headless build together with the export templates is downloaded, but if there is a cache hit, the files from the cache we created before are use.
```yml
- name: Download and config Godot Engine headless linux server and templates
    if: steps.cache-godot.outputs.cache-hit != 'true'
    shell: bash
    run: |
    wget -q https://github.com/huskeee/godot-headless-mac/releases/download/${{ inputs.godot-version }}-stable/Godot_v${{ inputs.godot-version }}-stable_mac_headless.64.zip
    wget -q https://downloads.tuxfamily.org/godotengine/${{ inputs.godot-version }}/Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
    unzip Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
    unzip Godot_v${{ inputs.godot-version }}-stable_mac_headless.64.zip
    mkdir -p ~/.config/godot
    mkdir -p ~/.local/share/godot/templates/${{ inputs.godot-version }}.stable
    mv templates/* ~/.local/share/godot/templates/${{ inputs.godot-version }}.stable
    mv bin/godot .
    ./godot -e -q
    rm -f Godot_v${{ inputs.godot-version }}-stable_linux_headless.64.zip Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
```


Now the game gets exported for iOS with this simple one liner. The exported files will be located in `$PWD/build/`.
```yml
- name: Godot iOS export
    shell: bash
    run: ./godot --path ${{ inputs.working-directory }} --export iOS
```


For the signing of the iOS export we need the UUID of the provisioning profile. With this command, the UUID gets extracted and and saved as PP_UUID in the Github Actions environment. 
```yml
- name: Extract Provisioning profile UUID and create PP_UUID env variable
    shell: bash
    run: echo "PP_UUID=$(grep -a -A 1 'UUID' ${{ inputs.provision-profile-path }} | grep string | sed -e "s|<string>||" -e "s|</string>||" | tr -d '\t')" >> $GITHUB_ENV
```

To make sure the runner uses the correct XCode version, we force it to use a version that works well with the Godot Engine.
```yml
- name: Force XCode 13.4
    shell: bash
    run: sudo xcode-select -switch /Applications/Xcode_13.4.app
```


Now we use the `xcodebuild` to make the iOS export ready for the upload.
If external dependencies are used with the following command the action makes sure that they are configured correctly.
```yml
- name: Resolve package dependencies
    shell: bash
    run: xcodebuild -resolvePackageDependencies
```


An archive of the export is needed before we can create the .ipa file that can be uploaded. In this step also the signing with the Developer Certificate and Provisioning Profile takes place.
```yml
- name: Build the xarchive
    shell: bash
    run: |
    set -eo pipefail
    xcodebuild  clean archive \
        -scheme ${{ inputs.project-name }} \
        -configuration "Release" \
        -sdk iphoneos \
        -archivePath "$PWD/build/${{ inputs.project-name }}.xcarchive" \
        -destination "generic/platform=iOS,name=Any iOS Device" \
        OTHER_CODE_SIGN_FLAGS="--keychain $RUNNER_TEMP/app-signing.keychain-db" \
        CODE_SIGN_STYLE=Manual \
        PROVISIONING_PROFILE=$PP_UUID \
        CODE_SIGN_IDENTITY="Apple Distribution"
```


The we can export the archive of the latest step to a single .ipa file that is ready for the upload.
```yml
- name: Export .ipa
    shell: bash
    run: |
    set -eo pipefail
    xcodebuild -archivePath "$PWD/build/${{ inputs.project-name }}.xcarchive" \
        -exportOptionsPlist exportOptions.plist \
        -exportPath $PWD/build \
        -allowProvisioningUpdates \
        -exportArchive
```


The final step uploads the .ipa file to the App Store using the `xcrun` tool.
A Apple user account with upload permission is needed and I recommend using a separate service account instead of the admin account.
```yml
- name: Publish the App on TestFlight
    shell: bash
    if: success()
    env:
    APPLEID_USERNAME: ${{ inputs.apple-id-username }}
    APPLEID_PASSWORD: ${{ inputs.apple-id-password }}
    run: |
    xcrun altool \
        --upload-app \
        -t ios \
        -f $PWD/build/*.ipa \
        -u "${{ inputs.apple-id-username }}" \
        -p "${{ inputs.apple-id-password }}" \
        --verbose
```


You can find the complete action on [Github](https://github.com/dulvui/godot-ios-upload/blob/main/action.yml).  
If you have problems or need help with the action simply open an issue in the repository.
