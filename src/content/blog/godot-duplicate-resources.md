+++
title = "Godot - How to deeply duplicate Resources, for real"
description = "A full guide on how to deeply duplicate Resources with all it's properties in Godot"
date = 2025-01-15T17:26:00+00:00
updated = 2025-01-15T17:26:00+00:00
draft = true
[extra]
mastodon_link = "https://mastodon.social/@dulvui/"
hackernews_link = "https://news.ycombinator.com/item?id="
+++

Resources in Godot are really powerful and can make a Game Devs life easier in many ways.
If you haven't used them yet, I can only recommend reading the
[official docs](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)
or my [blog post](@/blog/godot-custom-resources.md) about them. 

They are widely used in the editor itself, and even bring their own [security risks](https://github.com/godotengine/godot-proposals/issues/4925).
I'm using them a lot in my recent game.
For example all data objects are custom resources now.
Before that, everything was a Dictionary, until I simply had too many different objects to be able to remember property names.
Custom resources bring auto complete and certainty, that you access the correct properties.

So far so good, until I started duplicating them.
Reading the documentation would have saved me hours of debugging.
But well, also reading documentation takes time, so choose your poison :-)

## Create custom resources
Godot has already a lot of built-in resources.
But for this article, it's easier to create our own.

I will simply reuse some resources from my open-source game [99 Managers Futsal Edition](@/games/99managers-futsal-edition/index.md).
There we have **Players** with a name and surname.
```gd
class_name Player
extends Resource

@export var name: String
@export var surname: String

# custom resources need a _init function with default values
func _init(
    p_name: String = "",
    p_surname: String = "",
) -> void:
    name = p_name
    surname = p_surname

```

Let's see how Resources can be duplicated in Godot.

## Pointer assignments
The most trivial way to make from one resource two, is to assign it to a new variable.
```gd
var player_1: Player = Player.new("Gianluigi", "Buffon")
var player_2: Player = player_1
```
Here **no duplication** takes place, but you simply have two variables (or pointers), pointing to the **same** resource.
This is also useful if you want to keep a pointer to a resource somewhere for easier access or similar ideas.

But how can we verify, that they are the same?
Every resource in Godot has an unique id, aka [RID](https://docs.godotengine.org/en/stable/classes/class_rid.html),
that can be accessed with the **get_rid()** function.
```gd
# This assert test will pass, since both have the same RIDs
assert(player_1.get_rid() == player_2.get_rid())

# changing player_1's properties, will automatically also change player_2's properties
player_1.name = "Alessandro"
player_1.surname = "Del Piero"
assert(player_1.surname == player_2.surname)
```

## Shallow copy with duplicate()
Using **duplicate()** function creates a copy of the resource.
This function is also present also in other classes like Dictionary and Arrays.

To show how duplicate works, a bit more complicated resource is needed.
So let's create a team with a goalkeeper.
```gd
class_name Team
extends Resource

@export var name: String
@export var goalkeeper: Player

func _init(
    p_name: String = "",
    p_goalkeeper: Player = Player.new(),
) -> void:
    name = p_name
    goalkeeper = p_goalkeeper
```

```gd

# Let's create a team with a goalkeeper
var team: Team = Team.new("Italia", Player.new("Gianluigi", "Buffon"))
# and a another pointer to it
var team_pointer: Team = team
# and a copy of it
```

Note that now we have a Team resource with a **nested** Player resource.
```gd
# This assert test will no longer pass, since both have different RIDs
assert(player_1.get_rid() == player_2.get_rid())

# changing player_1's properties, will no longer change player_2's properties
player_1.name = "Alessandro"
player_1.surname = "Del Piero"
# False!
assert(player_1.surname == player_2.surname)
```


## Deep copy with duplicate(true)
```gd
class_name Team
extends Resource

@export var name: String
@export var field_players: Array[Player]

func _init(
    p_name: String = "",
    p_players: Array[Player] = [],
) -> void:
    name = p_name
    players = p_players

```

```gd
# Lets create once again two players
var player_1: Player = Player.new("Gianluigi", "Buffon")
var player_2: Player = Player.new("Alessandro", "Del Piero")
# and a team with the two players
var team: Team = Team.new("Italia", [player_1, player_2])
```

Note that now we have 
```gd
# This assert test will no longer pass, since both have different RIDs
assert(player_1.get_rid() == player_2.get_rid())

# changing player_1's properties, will no longer change player_2's properties
player_1.name = "Alessandro"
player_1.surname = "Del Piero"
# False!
assert(player_1.surname == player_2.surname)
```


## Real deep copy

