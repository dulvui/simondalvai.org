+++
title = "Create portals in Godot with _integrate_forces"
description = "Guide on how to create teleport portals, using Godot Engines _integrate_forces() function."
date = 2024-01-14T17:48:00
updated = 2024-01-14T17:48:00
[extra]
mastodon_link = ""
hackernews_link = ""
+++

My 3D Godot game [Ball2Box](@/games/ball2box/index.md) needs some variety, so I created some portals in for new levels.
This was not trivial to realize, as expected, and still needs some fine-tuning.
But the proof of concept works now finally, and it revealed quite easy to realize, if using the correct Godot functions.

Note: This are not portals like you might know from the game "Portal", where you can see trough the portal to the other side.
This portals simply teleport a moving body from one point to another.

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

The documentation of the _integrate_forces function writes
```sh
Called during physics processing, allowing you to read and safely modify the simulation state for the object.
```
**Safely** is here the keyword!
It means that there will be no strange glitches or non expected movements

Here the final working code, that not only teleports the ball from portal to portal, but also to its initial position.
```gd
extends RigidBody
class_name Ball

var do_teleport:bool = false
var do_reset:bool = false
var do_static:bool = false

var initial_position:Transform
var next_transform:Transform

func teleport(p_transform:Transform) -> void:
	next_transform = p_transform
	do_teleport = true

func teleport_to_initial() -> void:
	do_reset = true

func _integrate_forces(state:PhysicsDirectBodyState) -> void:
	# change the mode to static on the next iteration
	# otherwise ball doesn't move to new position
	if do_static:
		do_static = false
		mode = RigidBody.MODE_STATIC

	if do_teleport:
		state.transform = next_transform
		do_teleport = false

	if do_reset:
		state.transform = initial_position
		state.angular_velocity = Vector3.ZERO
		state.linear_velocity = Vector3.ZERO
		rotation = Vector3.ZERO
		do_reset = false
		do_static = true
```
An important difference here is, that instead of moving the ball directly, a flag gets set.
The actual movement happens then during the next _integrate_forces step.

For completion, here the code where the teleport function gets called, with the transform variable of the corresponding portal.
```gd
func _on_Portal1_ball_entered(ball:Ball) -> void:
	ball.teleport(portal2.transform)
```

After some refactoring of [Pocket Broomball](@/games/pocket-broomball/index.md), I found out that I already used _integrate_forces there to move the ball.
So I was already sitting on the solution, but forgot about it, as usual.

Find the full documentation of _integrate_forces [here](https://docs.godotengine.org/en/stable/classes/class_rigidbody3d.html#class-rigidbody3d-private-method-integrate-forces).

The full source code of Ball2box is available on [Github](https://github.com/dulvui/ball2box) and [Codeberg](https://codeberg.org/dulvui/ball2box).