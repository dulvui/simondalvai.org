+++
title = "How to publish a Godot Engine game to F-Droid"
description = "Automatically upload your iOS Godot game to the Apple App Store with Github Actions"
date = 2023-03-11
updated = 2023-03-11
draft = true
aliases = ["gfp"]
+++

[F-Droid](https://f-droid.org) is an awesome app that gives you access to thousands of Free and Open Source Software apps and games. 
It also respects your privacy and lets you know if an app has anti-features like tracking, ads, proprietary assets or if it depends on the proprietary Google Play Services.
Here a list of what F-Droid considers as Anti-Features: https://f-droid.org/docs/Anti-Features  
Now I was able to publish [Ball2Box](@/games/ball2box/index.md) to F-Droid and here I will share what steps are needed to do so.

## Requirements
To publish a [Godot Engine](https://godotengine.org) game to F-Droid you'll need an Open Source game with the source code publish on a public git repository.
You also need a Gitlab account to create a merge request to the F-Droid Data [repository](https://gitlab.com/fdroid/fdroiddata) or you can make an Application Proposal where others create the build recipe for you, but of course it is the slowest way.  
Here the documentation on how the inclusion works: https://f-droid.org/docs/Inclusion_How-To/

## Build recipe
F-Droid builds its apps itself and *all its dependencies* completely from the source.
That means that you need also to build the Godot Engine from its source code.
If you have other third party dependencies you will have to build from the source code also them.  
My game doesn't have any other dependency than the Godot Engine, so if your game has some, you will have to extend the following build recipe with the steps to build your dependencies.