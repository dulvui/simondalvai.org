+++
title = "Duplicate Godot custom resources deeply, for real"
description = "A full guide on how to deeply duplicate custom resources with all it's properties in Godot"
date = 2025-03-15T17:26:00+00:00
updated = 2025-03-15T17:26:00+00:00
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

## References
The most trivial way to make from one resource two, is to assign it to a new variable.
That creates a reference of the resource that still points to the same resource.
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
# True, since both have the same RIDs
assert(player_1.get_rid() == player_2.get_rid())

# changing player_1's properties, will automatically also change player_2's properties
player_1.name = "Alessandro"
player_1.surname = "Del Piero"
# True, because both variables point to the changed resource
assert(player_1.surname == player_2.surname)
```

## Shallow copy with duplicate()
Using **duplicate()** function creates a copy of the resource.
This function is also present in other classes like Dictionary and Array.

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

# Let's instantiate a team with a goalkeeper
var team_1: Team = Team.new("Italy", Player.new("Gianluigi", "Buffon"))
# and a copy of it
var team_2: Team = team.duplicate()

team_2.name = "Italy copy"
# Fail, because both teams are unique and independent resources
assert(team_1.name == team_2.name)

# changing player_1's properties, will no longer change player_2's properties
team_2.goalkeeper.name = "Ganluigi"
team_2.goalkeeper.surname = "Donnarumma"
# True, because both are named Gianluigi
assert(team_1.goalkeeper.name == team_2.goalkeeper.name)
# Also true, because the team_2's goalkeeper is a reference of the team_1's goalkeeper
assert(team_1.goalkeeper.surname == team_2.goalkeeper.surname)
```

So duplicate() creates a unique and independent resources, but all sub-resources will be **shallow copies**.
This means they are only references.

## Deep copy with duplicate(true)
The duplicate method has a boolean parameter called **subresources**, and this really does what it promises.
All sub resources get also duplicated and so when using the same code from the previous section, the last assert check for the surname will fail.

**Important** to know is that only resources with the **@export** annotation get deeply duplicated.
Additionally, this method will fail if **_init()** has been defined with **required parameters**.

```gd
# Let's instantiate a team with a goalkeeper
var team_1: Team = Team.new("Italy", Player.new("Gianluigi", "Buffon"))
# and a copy of it, with subresources set to true
var team_2: Team = team.duplicate(true)

team_2.name = "Italy copy"
# False, because both teams are unique and independent resources
assert(team_1.name == team_2.name)

team_2.goalkeeper.name = "Ganluigi"
team_2.goalkeeper.surname = "Donnarumma"
# True, because both still are named Gianluigi
assert(team_1.goalkeeper.name == team_2.goalkeeper.name)
# False, because the team_2's goalkeeper NO LONGER is a reference of the team_1's goalkeeper
assert(team_1.goalkeeper.surname == team_2.goalkeeper.surname)
```
Great, we can now duplicate resources now with all properties.
Well, actually not all of them.  
The documentation reads: "Subresources inside Array and Dictionary properties are **never** duplicated."

## Real deep copy
So there is currently no way to deeply duplicate a resource, with all it's sub-resources, using Godot's methods.
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
var team_1: Team = Team.new("Italy", [player_1, player_2])
```

Now we have a resource (team) with an Array of sub-resources (players).
Let's make some tests.
```gd
var team_2: Team = team_1.duplicate(true)
team_2.name = "Italy copy"
# lets change a players surname
team_2.players[0].surname = "Donnarumma"
# False
assert(team_1.name == team_2.name)
# True, because both player arrays still contain the same resources
assert(team_1.players[0].surname == team_2.players[0].surname)
```

So let's create a custom method to cover this special case.
```gd
func duplicate_real_deep() -> Team:
	var copy: Team = duplicate(true)
	copy.players = []
	for player: Player in players:
		copy.players.append(player.duplicate(true))
	return copy
```
Using this method, the tests from above will work as expected.
The same approach works with Dictionaries.
```gd
var team_2: Team = team_1.duplicate(true)
team_2.name = "Italy copy"
# lets change a players surname
team_2.players[0].surname = "Donnarumma"
# False
assert(team_1.name == team_2.name)
# False, because both players are unique resources
assert(team_1.players[0].surname == team_2.players[0].surname)
```
Here you can find the
[official documentation](https://docs.godotengine.org/en/stable/classes/class_resource.html#class-resource-method-duplicate)
of the duplicate method.

## In the meantime, my code changed
When I started writing this, I had the necessity to deeply duplicate resources.
In the meantime I refactored parts of the code to avoid using duplicates.  
This makes everything a lot easier to understand and to maintain.
Given that experience, I still want to share how it is possible, but highly recommend to check twice if it is really needed.

Said that, I also highly recommend to read the official documentation, as much as possible.
Godot has a really great documentation, included offline in the editor.
So even with no/low internet connections, you should be covered.
And to be honest, if I should have read the duplicate methods documentation better in the first place.
