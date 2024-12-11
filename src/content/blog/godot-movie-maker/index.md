+++
title = "Creating a Steam teaser with Godot Movie Maker"
description = "How I created the Steam teaser for my upcoming game 99 Managers Futsal Edition with Godot Movie Maker"
date = 2024-12-15T10:15:00+00:00
updated = 2024-12-15T10:15:00+00:00
draft = true
[extra]
mastodon_link = ""
hackernews_link = ""
preview_image = ""
+++

To release a game on Steam a video of the game is needed.
It doesn't really need to be a video about actual game play, but can also only be a teaser, where you announce your game.

I don't have much experience with video creation and editing, so I started to search the web for Open Source video editing tools.
The first I found where [OpenShot](https://www.openshot.org/) or [Kdenlive](https://kdenlive.org), which I already used and where quite happy with them.
But I used them mostly simply to edit existing videos, not to create new content from scratch.
Since they are quite resource intensive and a bit complicated if not used regularly, I mostly nowadays prefer [FFmpeg](https://www.ffmpeg.org/) for this.
FFmpeg is fast, can be used in command line and I can save the command in some file to automate or at least to remember it.

## Godot Movie Maker to the rescue
After some time spent on the web I remembered, that Godot actually has some feature called Movie Maker.  
I know how to use Godot + it can make movies = perfect match!

Godot's Movie Maker feature allows to create Movies with everything Godot is capable of.
So you can **code** you movie using Tweens, the AnimationPlayer or pure code.
The best part, everything is **automated** and supports versioning with **git**.
So for example, it's possible to **translate** the video in different languages with ease.
Or if you made a mistake and broke something, simply run **git restore** and your work is save.

## The first result
This is the final result of my teaser.

You can find it on [YouTube](https://www.youtube.com/watch?v=ToVRZsfPimE)
or if you prefer, **more privacy friendly** on [Mastodon](https://mastodon.social/@dulvui/113628533674230281).

It's quite simple with no special effects, except the ball fireworks at the end.
But I was quite fast to create it, can iterate it like I do with code and really love the idea of using Godot.

You can find the source code of the video
on [Codeberg](https://codeberg.org/dulvui/99managers-futsal-edition/src/branch/main/game/media)
or [Github](https://github.com/dulvui/99managers-futsal-edition/tree/main/game/media).  
Note: The location of the trailer files might change in the future, so this links might break.
Let me know if that happens, so I can fix it.

## Next video with game play
Having the complete game available while making the video is a big advantage.
This means I will be able to integrate game play scenes easily (at least I hope so).

## Performance
Video creation and editing and gaming (in a world before LLMs) are the most resource intensive software.
Godot isn't much different, but I have to say that it worked quite well on my potato laptop (dual code i5 7th gen, no GPU).
You can see the output directly while it is written to the file, and it takes about 2x more time.
So for a video of 10 seconds like mine, the task takes about 20 seconds.
But I can imagine that a proper laptop or desktop PC should be able to play and write the videos at normal speed.

## Final verdict
I would recommend using the Godot Movie Maker to everyone that knows how to use Godot or at least is eager to learn it.

<!--<img class="blog-image blog-image-wide" src="debian-sway-tools.webp" alt="A screenshot of three open terminals with hstr, nmtui and pulsemixer">  -->
