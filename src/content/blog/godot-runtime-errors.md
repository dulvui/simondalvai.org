+++
title = "Find more errors in Godot, with a script"
description = "How to find more errors in Godot, by writing a script to open all files and trigger errors."
date = 2025-05-15T16:10:00+00:00
updated = 2025-05-15T16:10:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/114512716650204211"
+++

I learned programming with Java, a statically typed language.
For that reason, I really miss **errors at compile time**, when programming with GDScript in Godot.
GDScript is a dynamically typed language, that makes error detection at compile time nearly impossible.  

There are many ways to make GDScript **more strict**, like adding type hints and making it
[statically typed](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html).
Additionally, treating more **warnings as errors** in its
[warning system](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/warning_system.html#doc-gdscript-warning-system),
will also have a positive effect on the amount of errors you will get.  

Anyways, some errors will only pop up, when you **execute** the script file **that has the error**.
Just change the name of a variable or a method and forget to update all references.
**BOOM**, your game will crash when the previous name get's accessed.
And in the worst case, this happens to the final user.

## Yet another script to the rescue
There is one trick that triggers the error: **opening the script** in the editor.
But it's impossible to open all files every time you make a change, by hand.
Given this, a good way to get more errors is to **open all script files, inside a script** ;-)  
So I created a script to search and load all **.gd** and **.tscn** files in the project.
This will then trigger some errors, you probably would have missed.
By opening also scene files, you might also catch **dependency errors**, after renaming files for example.

```gd
extends Node


func _ready() -> void:
	print("load all scenes...")
	var scene_paths: Array[String] = find_files(".tscn")
	# load scripts and check for possible dependency errors while loading
	for path: String in scene_paths:
		var TestScene: PackedScene = load(path)
		assert(TestScene != null)
		var instance: Node = TestScene.instantiate()
		assert(instance != null)
	print("load all scene done.")

	print("load all scripts...")
	var script_paths: Array[String] = find_files(".gd")
	# load scripts and check for possible runtime errors while loading
	for path: String in script_paths:
		var TestScript: GDScript = load(path)
		assert(TestScript != null)
	print("load all scripts done.")


func find_files(suffix: String, path: String = "res://") -> Array[String]:
	var scripts: Array[String] = []
	var dir: DirAccess = DirAccess.open(path)
	if dir == null:
		print("error while opening %s" % path)
		return scripts

	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	while not file_name.is_empty():
		var full_path: String = path + file_name
		if dir.current_is_dir():
			scripts.append_array(find_files(suffix, full_path + "/"))
		elif file_name.ends_with(suffix):
			scripts.append(full_path)
		file_name = dir.get_next()

	return scripts
```

This script can be executed by being attached to a scene that gets **launched from the editor**.
It can also be invoked from a **bigger test suite**, like I wrote for my game
[99Managers Futsal Edition](@/games/99managers-futsal-edition/index.md).

There I test also **game logic** and make sure that I don't make mistakes twice.
It also gives much more confidence, that the code is running as expected, after yet another refactoring session.
I have to admit, I **love refactoring**, so having tests helps a lot to keep the code working as expected.

## What's next
I already extended the script in my game to do even more, like **linting** and checking for
[dumb mistakes](https://mastodon.social/@dulvui/114471590023577302).
But that would be too much for this blog post.
If you still want to check it out, you can find the script on
[Codeberg](https://codeberg.org/dulvui/99managers-futsal-edition/src/commit/d1bec8f95cc2e1144c76c64d0e50c7fe76224d4d/game/src/tests/test_runtime_errors/test_runtime_errors.gd) and
[Github](https://github.com/dulvui/99managers-futsal-edition/blob/57c5b09632ec0ed5005f79d5e88cfd08b1a293cf/game/src/tests/test_runtime_errors/test_runtime_errors.gd).

Another idea I have is to run it **as main scene** of the game, so it will run every time I launch the game.
If the test passes, the splash screen gets loaded.
Except when the game is not running from the editor, in that case the splash screen will be loaded immediately.
