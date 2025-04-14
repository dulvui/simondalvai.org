+++
title = "Godot Engine vs libGDX"
description = "My personal experience with libGDX and Godot"
date = 2023-02-26T00:00:00+00:00
updated = 2023-02-26T00:00:00+00:00
draft = false
[extra]
mastodon_link = "https://mastodon.social/@dulvui/110486059574305335"
+++

I create games since 2018 and here I want to share my experience with [libGDX](https://libgdx.com/) and [Godot](https://godotengine.org/).
Both are open source and completely free to use with no revenue share or license prices, like other game development environments have.
In total, I currently released 3 games with libGDX and 2 with Godot for Android and iOS.  
I started in 2018 with libGDX because I knew how to code Java and liked the fact that everything is code and there's no GUI editor where I have to click checkboxes and hoping to remember which one did what.
Then, around 2020 I tried to use Godot version 3 and I really loved how it worked.
So, since then I develop games only with Godot but still maintain my libGDX games and I'm working on releasing them all on iOS.  
**Note:** This is my own experience that I want to share with you but of course some things might be subjective and biased by my opinions.
So, the best advice I can give is to try all game development environments that you want and find the one that works for you.   

## libGDX
LibGDX is a simple but powerful Java library for cross-platform game development. 
You can create 2D and 3D games for Windows, macOS, Linux, Android, iOS and HTML5. 
You need to code everything in Java and there's no Editor like you get with Godot.
So, you can use your favorite Java IDE like Eclipse, IntelliJ, Android Studio or whatever you prefer.
This makes libGDX really powerful because it lets you control and define every aspect of your game.
From loading the assets, to freeing the memory and positioning the button is done by you and by pure code.
No automatic memory management or graphical editor to make this tasks easier.
It is still active maintained but it hasn't a big developer community like Godot.
Unity has probably the biggest mobile games development community.
Since you can add every other Java or Android library of your choice, it supports a lot of third party plugins.

## Android
Java and Kotlin are the official programming languages for Android and so, libGDX works really well on Android.
The final App size is really small.
My games are less than 3 MB big and the performance is really great.
I haven't stress tested the performance, but it seems much faster than Godot, especially on older devices.
You can build your games with gradle and also use automated CI/CD tools to automate everything.
Here you can find my Github Action to export and upload your games to the Google Play Store  
https://github.com/dulvui/libgdx-ios-upload

## iOS
LibGdx also works on iOS using the [RoboVM](https://github.com/robovm/robovm-gradle-plugin) gradle plugin.
It translates the Java code into iOS machine code and so it can work on iPhones.
The performance is good but the app size increases drastically.
The 3 MB now raise to around 50 MB or more, but it is the price to pay to have libGDX on iOS devices.
I also created a Github Action to export and upload your games to the Apple App Store  
https://github.com/dulvui/libgdx-ios-upload

## Useful tools
The most useful tool I found to create your UI elements is the libGDX Skin Composer  
https://libgdx.com/wiki/tools/skin-composer  
This tool gives you a easy way to create your custom buttons, fonts, labels etc. with a GUI editor.
It seems that now this tool also has a Scene Composer, I haven't tried it yet.
So you can even create your game's GUI with this tool without having to code.


## Godot
Godot is a also cross-platform game engine that has only a single executable without any other dependencies.
You simply need to download the around 30 MB big executable and run it on your Linux, Windows or macOS machine.
Since the editor itself is created with Godot and Godot can be exported to Android, there is even a running editor for Android.
It is still buggy and in early stage but it works!
Godot is still young (initial release 2014) but it already has a big community and a lot of contributors.
One downside of Godot (at the time of writing this, early 2023) is that some plugins, that you can easily find for other game engines, like Firebase or AdMob, have no official release and are solely created by the Godot community.
So the plugin you use today, might not work tomorrow, until you fix it by yourself.
I tried Google AdMob and Firebase on Godot, but then removed them, because I no longer wanted to contribute to privacy invading and with Ads loaded games.
Thus, I removed all third party libraries and hope to make a few bucks only with [donations](/donate).

## Android
Godot works well on Android and an empty game is about 8 MB big.
My games are between 30 and 50 MB big, but most of the memory comes from the assets.
And of course, I also created a Github Action for Godot to export and upload your game to the Google Play Store  
https://github.com/dulvui/godot-android-export  


## iOS
Godot also works well with iOS, but you'll need a macOS device to export, execute and upload the game to the App Store.
Or you simply use my Github Actions that does the uploading automatically for you, with no physical Mac device needed  
https://github.com/dulvui/godot-ios-upload  


## Final thoughts
If you know Java well and you want to take completely control of your game, then libGDX is perfect for you.
But if you like fast development, creating your UI by mouse dragging and clicking, you should go for Godot.
Both are powerful tools to create games.
I must say that starting with libGDX taught me the basics of game programming, from loading and freeing the used assets to using the game loop for drawing them.
So, switching then to Godot allowed me to appreciate all the magical automated tasks that Godot does behind the scenes even more.
As a result, I can focus more on the actual game than needing to code each button position manually.
