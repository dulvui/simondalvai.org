+++
title = "Custom Resources in Godot Engine 4.x"
description = "Guide on why and how to use Custom Resources in Godot Engine 4.x pointing out advantages and features."
date = 2023-10-16
updated = 2023-10-16
[extra]
mastodon_link = ""
hackernews_link = ""
+++

## Godot Resources in a nutshell
Godot has a lot cool features built in that make game development a joyful ride.
One of this awesome features are **Custom Resources**.

Technically all the parts of Godot that save some data extend the Resource class.
They are data containers that can contain all sort of data: translations, audio, textures and much more.
This are all built-in Resources, but you can create also you own Custom Resources, that help you defining data structures and bring a lot of other features.

I learned about Custom Resources quite late, since I was able to all my data related problems with Dictionaries and JSON files.
But now I work on bigger projects, like [Futsal Manager](https://simondalvai.org/games/futsal-manager/) where I need a lot of data.
In such complex projects Custom Resources are a big game changer and make the development easier, with less errors and faster development.

## Custom Resources
You can create your own Custom Resources simply by creating an empty Script file, giving it a class_name and extending it with the Resources class.
Then you can define some variables, enums, constants and methods like in this example:
```gd
class_name MyResource
extends Resource

signal such_signal

enum SuchEnum { Hello, Custom, Resources }

@export var name:String
@export var id:int = 0
@export var values:Array[int]
@export var enumValue:SuchEnum

func get_sum() -> int:
    var sum:int = 0
    for value in values:
        sum += value
    return sum

func special_effect() -> void:
    if randi() % 10 == 1:
        such_signal.emit()
```

Now you can create a variable of the type MyResource and you get the functions and variables name with the editors autocomplete.
So you are sure that you always use the correct variable name.
With Dictionaries instead, you have to remember the names of the keys.  
By using the @export annotation you can modify all your resources directly in the editor.

## Save and load
Another cool feature is the built-in load and save to disk functionality.
So you can replace all your JSON files with built-in Custom Resources.  
Note: Only variables with @export annotation get saved to disk.

Here an example:
```gd
# create variable
var my_resource:MyResource = MyResource.new()

# assign values
my_resource.name = "Hello Resources"
my_resource.values = [0, 3, 12]

# save it
ResourceSaver.save(my_resource, "res://my_resource.tres")

# load it
var my_resource_from_disk:MyResource = load("res://my_resource.tres")

# prints "Hello Resources"
print(my_resource_from_disk.name)


# prints "15"
print(my_resource_from_disk.sum())

```
Good to know is that during runtime you can write resources only into the `user://` directory.
Files from the `res://` directory are read only.
So if you want to save data the user modified or created, you need to save them into the `user://` directory.

## Complex data structures
With custom resources you can create all kind of data you can imagine.
So you can use a created resource in another one.
So for example if you create a football team, you can split the team and its players with its own resources.

Here some code of my Futsal Manager game:


```gd
# team.gd
extends Resource
class_name Team

@export var name:String
@export var line_up:LineUp
@export var prestige:int
@export var budget:int
@export var salary_budget:int
@export var players:Array[Player]

# ...code goes on here
```

```gd
# player.gd
class_name Player
extends Resource

@export var id:int
@export var price:int
@export var name:String
@export var surname:String
@export var birth_date:Dictionary

# ...code goes on here
```

So with this two resources, I can define the `players` variable in teams that is an Array of Players and can contain only variables of the type `Player`.
This makes the code type safe and gives you code autocompletion in the editor.
Theres is no limit on how many Resources and Sub-resources you create.

## .tres vs .res
Resources can be saved in two file formats **.tres** that are version-control-friendly and human readable.
**.res** files instead are binary files and have better speed and compression.
So depending on what data your store, you might prefer one or the other.
It makes sense to save users data as .res files, for performance and to save disk space.

## Further readings
This was just my personal experience and knowledge about Godot's Custom Resources.
They surely can do even more interesting stuff and there is a lot of other information on the web.

Here you can read more about Resources in the official Godot [documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html) on how to use Resources and what features they bring.
And here you can find the official [class reference](https://docs.godotengine.org/en/stable/classes/class_resource.html#class-resource).
