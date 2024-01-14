+++
title = "Create portals in Godot, aka moving bodies using _integrate_forces"
description = "Guide on how to create teleport portals, using Godot Engines _integrate_forces() function."
date = 2024-01-14T17:48:00
updated = 2024-01-14T17:48:00
draft = true
[extra]
mastodon_link = "https://mastodon.social/@dulvui/111087833333535854"
hackernews_link = "https://news.ycombinator.com/item?id=37560886"
+++

Myy 3D Godot game [Ball2Box](@/games/ball2box/index.md) needed some variety, so I started to use portals in the new levels.
This was not trivial to realize, as expected, and still needs some fine-tuning.
But the proof of concept works now finally, and it revealed quite easy to realize, if using the correct Godot functions.

## First attempts
The goal of the game is to get the ball into the box with only one shot.
If the attempt fails, the ball gets reset to its initial position.
So technically, I already had a "teleport" of the ball from it's final position to the initial position.

Here the old code of the "reset to initial position" function.
It simply changes the mode of the RigidBody to static, so it can be moved by changing the translation Vector.
Then it also resets all velocity and rotations, to make sure the ball remains still.
```gd
extends RigidBody
class_name Ball

# ...omitted code

func reset() -> void:
    mode = RigidBody.MODE_STATIC
    translation = initial_position
    linear_velocity = Vector3.ZERO
    angular_velocity = Vector3.ZERO
    rotation = Vector3.ZERO
```

Of course I ignored the warnings about changing game physics outside the physic process, because well, it worked.

## _integrate_forces(), the forgotten solution
Obviously, I taught this would work also for portals, where the ball gets teleported without resting the velocity and rotation.
After a few attempts making it work, I tried searching the web, and luckily found some hint on using **_integrate_forces**.  
Surely somehow it would have worked without it, after banging my head for some hours, but using this function is the correct way.

The documentation of the _integrate_forces function writes:  
```sh
Called during physics processing, allowing you to read and **safely** modify the simulation state for the object.
```

Safely is here the keyword!




Find the full documentation of _integrate_forces() [here](https://docs.godotengine.org/en/stable/classes/class_rigidbody3d.html#class-rigidbody3d-private-method-integrate-forces).

