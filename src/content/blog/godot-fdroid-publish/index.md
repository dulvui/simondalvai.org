+++
title = "How to publish a Godot Engine game to F-Droid"
description = "How to build and publish an Open Source Godot Engine game to F-Droid"
date = 2023-04-22
updated = 2023-04-22
draft = false
aliases = ["gfp"]
+++

[F-Droid](https://f-droid.org) is an awesome app that gives you access to thousands of Free and Open Source Software apps and games. 
It also respects your privacy, requires no login and lets you know if an app has anti-features like tracking, ads, proprietary assets or if it depends on the proprietary Google Play Services.
If an app has ads or tracks you, it is marked as [AntiFeatures](https://f-droid.org/docs/Anti-Features).
<img class="blog-image" src="antifeatures.png" alt="AntiFeatures example">  
Last month I was able to publish [Ball2Box](@/games/ball2box/index.md) to [FDroid](https://f-droid.org/en/packages/com.simondalvai.ball2box/) and here I will share the steps that are needed to do so.  

## Requirements
To publish a [Godot Engine](https://godotengine.org) game to F-Droid you'll need an Open Source game with the source code published on a public git repository.
You also need a Gitlab account to create a merge request to the F-Droid Data [repository](https://gitlab.com/fdroid/fdroiddata) or you can make an Application Proposal where others create the build recipe for you, but of course it is the slowest way.  
Here the documentation on how the inclusion works: https://f-droid.org/docs/Inclusion_How-To/
You also need a metadata [directory](https://github.com/dulvui/ball2box/tree/main/metadata) in your repo with some screenshots, a description and the changelogs of your game.

## Building the game
F-Droid builds its apps itself and *all its dependencies* completely from the source.
That means that you need also to build the Godot Engine from its source code.
If you have other third party dependencies you have also to build them from the source code.
My game doesn't have any other dependency than the Godot Engine, so if your game has some, you will have to extend the following build recipe with the steps to build your dependencies.  
All the steps needed are written in a yaml recipe file.

1. Fork the fdroiddata repo from Gitlab https://gitlab.com/fdroid/fdroiddata
2. Create a new branch with the package name of your game, like `com.simondalvai.ball2box` in my case
3. Create a new file in the metadata directory named with your package name again, like `com.simondalvai.ball2box.yml` in my case
   1. You can copy my file and rename it if you want
4. Fill or replace all values with your data



