+++
title = "Get better errors in GDScript"
description = "How to get better runtime errors in GDScript by writing tests."
date = 2025-05-18T15:00:00+00:00
updated = 2025-05-18T15:00:00+00:00
draft = true
[extra]
mastodon_link = ""
+++

What I miss mostly in GDScript are **errors at compile time**.
GDScript is a dynamically typed language and that makes error detection at compile time nearly impossible.
There are many ways to make it **more strict**, like adding type hints and making
[GDScript statically typed](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html).
Additionally treating more warnings as errors in
[GDScript's warning system](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/warning_system.html#doc-gdscript-warning-system)
will also have a positive effect on the amount of errors you will get.
Lately I'm treating neatly all possible warnings as errors in my projects.  
But still some errors will only pop up, when you execute the script file **that has the error**.
So maybe you changed the name of a variable or a method name and forgot to update all code parts that use it.

## Yet another script to the rescue
Opening the files in the editor will trigger the errors.
But it's impossible to open all files every time you make a change.
Given this, a good way to get more errors is to **open all script files, inside a script** ;-)  
So I created the following code to searches for all .gd and all .tscn files in the project and loads them.
This will magically show errors, that would otherwise not be noticed on startup of the game.

**Attention:** This script assumes that you have a `res://src/` directory where all .gd and .tscn files are located.
You can simply change it to `res://` or whatever your project structure is.

```gd
extends Node


func _ready() -> void:
	print("load all scenes...")
	var scene_paths: Array[String] = find_files("res://src/", ".tscn")
	# load scripts and check for possible errors while loading
	for path: String in scene_paths:
		var TestScene: PackedScene = load(path)
		assert(TestScene != null)
		var instance: Node = TestScene.instantiate()
		assert(instance != null)
	print("load all scene done.")

	print("load all scripts...")
	var script_paths: Array[String] = find_files("res://src/", ".gd")
	# load scripts and check for possible runtime errors while loading
	for path: String in script_paths:
		var TestScript: GDScript = load(path)
		assert(TestScript != null)
	print("load all scripts done.")

	print("runtime errors done.")


func find_files(path: String, suffix: String) -> Array[String]:
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
			scripts.append_array(find_files(full_path + "/", suffix))
		elif file_name.ends_with(suffix):
			scripts.append(full_path)
		file_name = dir.get_next()

	return scripts
```

This script can be executed by being attached to a Node in a Scene that get's launched from the editor.
Or also invoked from a bigger test suite, like I wrote for my game
[99Managers Futsal Edition](@/games/99managers-futsal-edition/index.md).
There I test also game logic and make sure that I don't make mistakes twice.
It also gives much more confidence, that the code is running as expected, after yet another refactoring session.
I have to admit, I love refactoring my existing code, so having some safeguards help a lot to keep ship floating.

This of course still doesn't get all errors your code could and will have.
But it detects a huge amount in a few seconds.
There might be other checks I could add to the script and if you have ideas, feel free to contact me.
