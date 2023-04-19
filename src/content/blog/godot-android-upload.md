+++
title = "Automated Godot Android upload"
description = "Automatically upload your Android Godot game to the Google Play Store with Github Actions"
date = 2023-01-15
updated = 2023-01-17
aliases = ["gau"]
+++

In my last blog [post](@/blog/godot-ios-upload.md) I explained how my Github Action, to automatically export and upload Godot iOS games to the Apple App Store, works.
I created the same action for Android and the Google Play Store and in this post I will explain how it works.
I'm using also this action already in my Godot games, like [PocketBroomball](https://github.com/dulvui/pocket-broomball/blob/main/.github/workflows/upload-android.yml) or [Ball2Box](https://github.com/dulvui/ball2box/blob/main/.github/workflows/upload-android.yml).  
You can find the repo of the action on [Github](https://github.com/dulvui/godot-android-export).

## How does this action work?
The first step is setting up Java for the Github runner with the `actions/setup-java@v3` action. This downloads everything needed and sets the environment variables like JAVA_HOME etc.
```yml
- name: Set up JDK 1.8
    uses: actions/setup-java@v3
    with:
    distribution: 'temurin'
    java-version: 11
```

The Android SDK and its tools are another must have and for that we run the `android-actions/setup-android@v2` action.
```yml
- name: Setup Android SDK
    uses: android-actions/setup-android@v2
```

Then a cache is created using the `actions/cache@v3` action. This cache saves the Godot Engine executable, configurations and export templates in a persistent memory, in order to save time and Github's bandwidth. A new cache is created if the `godot-version` of the inputs changes.
```yml
- name: Cache Godot files
    id: cache-godot
    uses: actions/cache@v3
    with:
    path: |
        ~/.local/share/godot/**
        /usr/local/bin/godot
        ~/.config/godot/**
    key: ${{ runner.os }}-godot-${{ inputs.godot-version }}
```

Now the headless Godot executables get downloaded but only if the cache, created the step before, doesn't get a hit.
The needed export templates get downloaded and extracted too.
```yml
- name: Download and config Godot Engine headless linux server and templates
    if: steps.cache-godot.outputs.cache-hit != 'true'
    shell: bash
    run: |
    wget -q https://downloads.tuxfamily.org/godotengine/${{ inputs.godot-version }}/Godot_v${{ inputs.godot-version }}-stable_linux_headless.64.zip
    wget -q https://downloads.tuxfamily.org/godotengine/${{ inputs.godot-version }}/Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
    mkdir ~/.cache
    mkdir -p ~/.config/godot
    mkdir -p ~/.local/share/godot/templates/${{ inputs.godot-version }}.stable
    unzip Godot_v${{ inputs.godot-version }}-stable_linux_headless.64.zip
    mv Godot_v${{ inputs.godot-version }}-stable_linux_headless.64 /usr/local/bin/godot
    unzip Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
    mv templates/* ~/.local/share/godot/templates/${{ inputs.godot-version }}.stable
    rm -f Godot_v${{ inputs.godot-version }}-stable_linux_headless.64.zip Godot_v${{ inputs.godot-version }}-stable_export_templates.tpz
    godot -e -q
```


Now the path for the Android SDK can be defined in the Godot Editor settings, so that the engine knows, where to find the SDK and build tools.
```yml
- name: Set Android SDK path in Godot Editor settings
    if: steps.cache-godot.outputs.cache-hit != 'true'
    shell: bash
    env:
    SETTINGS: |
        export/android/android_sdk_path = "/usr/local/lib/android/sdk"
        export/android/shutdown_adb_on_exit = true
        export/android/force_system_user = false
    run: echo $SETTINGS >> ~/.config/godot/editor_settings-3.tres
```

The setup of Java, Android and Godot is now complete and we can actually export the game with this simple one liner.
Godot is quite cool, isn't it?
```yml
- name: Export
    shell: bash
    run: godot --path ${{ inputs.working-directory }} --export Android
```

And now we can run the final step by uploading the exported game to the Google Play Store using the `uses: r0adkll/upload-google-play@v1` action.
```yml
- name: Publish to Play Store
    uses: r0adkll/upload-google-play@v1
    with:
    serviceAccountJson: ${{ inputs.service-account-json }}
    packageName: ${{ inputs.package-name }}
    releaseFiles: ${{ inputs.release-file }}
    track: ${{ inputs.release-track }}
    status: completed
```

The Android action is quite simpler than the iOS action and also easier to maintain because you don't have to care about yearly expiring Developer Certificates and Provisioning Profiles. Probably it is because I'm simply too unexperienced with iOS development and thus it is a pain every time I need to renew everything. But automating, at least the export and upload, is a big help, especially as a solo developer. It saves me a lot of time and brings much more joy when you can upload everything with a simple `git push`.

You can find the complete action and instructions on [Github](https://github.com/dulvui/godot-android-export/blob/main/action.yml).  
If you have problems or need help with the action, simply open an issue in the repository.