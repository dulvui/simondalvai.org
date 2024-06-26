+++
title = "Porting my libGDX games to Godot"
description = "Porting my libGDX games to Godot for better maintainability and development"
date = 2023-07-20T00:00:00+00:00
updated = 2023-07-20T00:00:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/110747423147539606"
hackernews_link = "https://news.ycombinator.com/item?id=36803161"
+++

After using libGDX, since 2020 I create my games only with Godot Engine.
I find Godot easier and faster than libGDX.
There is also to say that libGDX is just a Java Framework and Godot is a full Engine.
I already wrote a [blog post](@/blog/godot-vs-libgdx.md) about libGDX vs Godot comparing the main differences and my experience with both.

Now I've decided that I will port my old games to Godot, since it might actually be the better way to keep my games up to date.

## My motivations
Using libGDX every few months, to make a few changes or update some SDK or dependency is always a pain.
Especially for libGDX iOS games, because [robovm](https://github.com/MobiVM/robovm) is needed, to compile the Java code for iOS.
I spend hours to fix the dependency issues and end up with a setup that somehow works, but I don't really understand how and why.
That repeats every few months.  
Of course, if I would learn gradle better I might be able to be much faster.
But I find it very hard learning things I barely use.
And this will be the last time I face a dependency version mismatch, gradle build errors and hours of cryptic debugging.

Another big motivator is that the Apple App Store removes all app that didn't get an update in the last 2 years ( or is it 3? I found different articles with different years).
So anyway I would have to do an update at least every 2 years, even if nothing changes in the game.

I still need to say that libGDX is really great.
I enjoyed the time and learned a lot.
If you use it often and don't target iOS, it's a great and powerful framework.
But in my case, it's better to say good bye.

## Why Godot Engine?
Godot is one of the most promising and growing Open Source Game Engine with a great community.
As said before, Godot is quite easy to learn.
It makes the maintenance of a game also much easier.
The only time you really need to take a step back and learn new things, is when a new major version comes out.

Not having to fight with gradle is also a big plus for me.
And the good thing is, if you like gradle, you can still use it for Android with Godot's custom build feature.

Finding help online is also much easier, since there is a big community and really nice docs.
And it just works.
Exporting a game for Android, iOS, html, Desktop etc simply works out of the box.
No need for special tools or knowledge of other software than Godot.

## What games will be ported?
I will port for first [Sn4ke](@/games/sn4ke/index.md) to Godot.
It is the game with most downloads and the game I spent most time to create it.
It's also the only libGDX game I currently have on iOS.

After that I will port [WhatColor](@/games/whatcolor/index.md).
There I will also extend and improve the game with sound, more levels, tutorials etc...
It will then also be published for iOS.

Last and least, my very first game [ColorShooter](@/games/color-shooter/index.md).
I still don't know if I will port this game, but maybe some nostalgia will motivate me to do so.
Anyway, if you see updates on this game, it will surely be made with Godot.
