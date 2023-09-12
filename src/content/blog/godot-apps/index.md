+++
title = "Create non-game apps with Godot Engine"
description = "My personal experience on how I use Godot Engine to create non-game applications"
date = 2023-09-12
updated = 2023-09-12
draft = true
[extra]
mastodon_link = "https://mastodon.social/@dulvui/"
hackernews_link = "https://news.ycombinator.com/item?id="
+++

The main target of the Godot Engine is of course creating games.
But it's easy workflow and awesome UI elements makes it also possible to create non-game applications.
There are already some out there you may know, like [Pixelorama](https://github.com/Orama-Interactive/Pixelorama), an Open Source 2D sprite editor.

## Condor is born
Recently I also started creating a an application made with Godot Engine, named "Condor".
Currently It's mobile and desktop app for managing the Italian Fantasy Football "Fantacalcio" auction.
If you never heard of "Fantacalcio" or "Fantasy Football", its a game where you compete with a group of friends, by buying real football players and get points every match day, depending on the real life performance.
You can read here more about it on [Wikipedia](https://en.wikipedia.org/wiki/Fantasy_football_(association)).

The name "Condor" derives from the nickname "il condor" of [Adriano Galliani](https://en.wikipedia.org/wiki/Adriano_Galliani).
He gained the name by his strategy of buying football players the last hours of the transfer market, to get better conditions, because teams want to get rid of some players they where not able to sell yet.

There are already some apps out there, but non of them (at least as I found) is Open Source and available for Linux, without ads and tracking.
You can find the source code on [Github](https://github.com/dulvui/condor) or [Codeberg](https://codeberg.org/dulvui/condor) as usual.

## First impressions
For now I really enjoy creating apps with the Godot Engine, since it is really easy to create complex UI's fast.
Its perfect for fast prototyping and Godot's Scene/Node architecture with signals, makes it quite easy to understand.
Since the whole Engine is Open Source, you can find a lot of code and sample project out there.

## WebSockets and Hetzner Cloud
One goal of the application is also to make it possible to follow the auction remotely.
So all participants can see all football players someone bought during the auction, the remaining budget, still available players and participate at the auction with the auction timer buzzer.

To finalize this, I used simple a simple WebSockets client/server architecture and the cheapest Hetzner cloud server for around 4€ per month.
I used Godot's official WebSocket chat demo project you can find on [Github](https://github.com/godotengine/godot-demo-projects/tree/master/networking/websocket_chat)

## Testing in real auction

<img class="blog-image" src="condor.webp" alt="Screenshot of the application 'Condor'">  


## Release date
This year I will use the app only internally for my own Fantacalcio league, but I plan to release it to the public for the next season 2024/2025.
So the application will be released for mobile, desktop and web during summer 2024.

## Final verdict
I really enjoyed creating this application, since I learned a lot, especially on how to cerate stable und working UIs in Godot.
It was also my first online multiplayer experience with Godot, so I learned a lot.
So if you already know or want to learn Godot and you have an idea for an application, that should be implemented fast but solid and for multiple platforms, give Godot a try.