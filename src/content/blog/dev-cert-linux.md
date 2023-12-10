+++
title = "Create Apple Developer Certificate on Linux"
description = "Guide on how to create Apple Developer Certificate on Linux without a Mac"
date = 2023-12-10
updated = 2023-12-10
[extra]
mastodon_link = "https://mastodon.social/@dulvui/111557144399329382"
hackernews_link = "https://news.ycombinator.com/item?id=38592832"
+++

To upload a app to the App Store, you need to create a Developer Certificate.
The official Apple guide shows you how to do it easily with a Mac device in its official [documentation](https://developer.apple.com/help/account/create-certificates/create-a-certificate-signing-request).
But it can be done also without a Mac, using a Linux System, following [this guide](https://gist.github.com/jcward/d08b33fc3e6c5f90c18437956e5ccc35) of a Github user.

## How to do it

1. Generate a private key and certificate signing request:
Firs create a private key with openssl
```sh
openssl genrsa -out distribution.key 2048
```
Then you can create a Certificate Sign Request, shortly CSR, using the previously generated private key.  
Note: change "info@simondalvai.org" and "Simon Dalvai" with your values.
```sh
openssl req -new -key distribution.key -out distribution.csr -subj '/emailAddress=info@simondalvai.org, CN=Simon Dalvai, C=IT'
```

2. Upload the CSR to apple at: https://developer.apple.com/account/ios/certificate/create
Choose Production -> App Store and Ad Hoc

3. Download the resulting distribution.cer, and convert it to .pem format:
```sh
openssl x509 -inform der -in distribution.cer -out distribution.pem
```

4. Download Apple's Worldwide developer cert from portal and convert it to pem:  
   https://www.apple.com/certificateauthority/ - Worldwide Developer Relations - G4 (Expiring 12/10/2030 00:00:00 UTC
```sh
openssl x509 -in AppleWWDRCAG4.cer -inform DER -out AppleWWDRCAG4.pem -outform PEM
```

5. Convert your cert plus Apple's cert to p12 format (choose a password for the .p12).  
Note: use -legacy if using opensssl v3.x . Found on [StackOverflow](https://stackoverflow.com/questions/70431528/mac-verification-failed-during-pkcs12-import-wrong-password-azure-devops)
```sh
openssl pkcs12 -export -legacy -out distribution.p12 -inkey distribution.key -in distribution.pem -certfile AppleWWDRCAG4.pem 
```

6. Finally, update any Provisioning Profile with the new cert, and download them from dev portal.
   Now you can also sign any Provisioning Profiles with the new certificate and use them to release apps. 

## Use in CI/CD like Github Actions
The Developer Certificate and Provisioning Profile can be imported in any CI/CD system, like Github Actions.
But most CI/CD systems don't support binary files, so the conversion to base64 is needed.

1. Create base64 of distribution.p12
Now you can prepare the Developer Certificate for the Github Action.  
Note: use `-w 0` to prevent new lines in the resulting base64 string.
```sh
base64 distribution.p12 -w 0 > distribution.base64
```

2. Add distribution.base64 content to your CI/CD systems secrets

3. Recreate the file in its binary format 
```sh
echo -n "$BUILD_CERTIFICATE_BASE64" | base64 --decode -o distribution.p12
```

The same steps work with any binary file, like the Provisioning Profile.

