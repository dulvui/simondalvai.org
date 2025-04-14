+++
title = "How to not install LineageOS 20 on Pixel 5 in 2023"
description = "How to install LineageOS 20 on Pixel 5 in 2023 with Debian. What is needed and how to recover from eventual mistakes."
date = 2023-07-08T00:00:00+00:00
updated = 2023-07-08T00:00:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/110677519803530168"
+++

I just bought a refurbished Pixel 5 to upgrade from my Samsung Galaxy S5.
The Samsung is still getting updates on [LineageOS](https://lineageos.org/) 18.1 and working fine for simple tasks, but I felt that it was time to change phone.
I looked for a while what phone I should buy, since I wanted a compact phone, so there were not many options.  

A must have is LineageOS 20 support, so I found this awesome page [lineageosdevices.com](https://lineageosdevices.com/) where you can compare devices that can run the latest version.
So I found the Pixel 5, that is quite new (released 2020) and small (6 inches, but only 144.7 mm height).

The install process was not as simple as I taught, since I made some mistakes.  
With this blog post I will share what I did wrong and how to fix eventual boot loops or other problems.

## Read the guide, really do it
Read and follow carefully the official install guide  
[https://wiki.lineageos.org/devices/redfin/install](https://wiki.lineageos.org/devices/redfin/install)  
It will prevent a lot of mistakes, if I would have read it more carefully I would have taken less time.
If you really follow the guide it will take you around 20 minutes to install it. It took me around 3 hours.

## What went wrong - fastboot version
Firstly I used an **old fastboot version**.
Debian's fastboot version is a bit old, so you need to download fastboot from the official Android site  
[https://developer.android.com/tools/releases/platform-tools#downloads](https://developer.android.com/tools/releases/platform-tools#downloads)  
The LineageOS guide also mentions this, but since I didn't read the guide carefully, shit happened.

## What went wrong - TWRP
Alongside LineageOS, I always install the TWRP custom recovery menu from  
[https://twrp.me](https://twrp.me)  
For some reasons, when trying to temporarily boot TWRP on the Pixel 5, it always stayed stuck on the TWRP splash screen.
The first time I used the old fastboot version, but also after using the new one adn re-flashing the stock rom, I always had the same problem.  
So I installed the **Lineage recovery menu**, but also with no success.
My phone got stuck in several boot loops and I was not able to boot the stock rom.  
If you know how to fix this, please let me know.

## The rescue - flash the stock rom
My phone was completely broken.
It didn't boot the stock rom, recovery menu didn't boot either.
Only the fastboot bootloader was still working.
If you encounter boot loops or other problems like me, a good solution is to flash the stock rom again.
You can flash it manually or you can use this amazing website, that will do all the work for you.  
[https://flash.android.com/back-to-public](https://flash.android.com/back-to-public)

You need a Chrome browser to use it, so I installed Chromium and it worked fine.

## Final sprint
After flashing the stock rom I followed exactly the LineageOS guide, with the latest fastboot version and no TWRP but Lineage recovery menu.
Then finally after 3 hours and a lot of tears, LineageOS 20 booted correctly on my new Pixel 5.
This took me just around 20 minutes, so as usual, the best advice is to **really read the docs**.

## Long story short

- Read the docs carefully
- TWRP didn't work for me
- Use latest fastboot version
- Flash stock rom to start from scratch
