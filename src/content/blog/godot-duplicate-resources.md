+++
title = "Duplicate Godot custom resources deeply, for real"
description = "A full guide on how to deeply duplicate custom resources with all it's properties in Godot"
date = 2025-03-18T15:00:00+00:00
updated = 2025-03-18T15:00:00+00:00
[extra]
mastodon_link = "https://mastodon.social/@dulvui/114184035048713465"
hackernews_link = "https://news.ycombinator.com/item?id=43400292"
+++

Resources in Godot are **really powerful** and can make a Game Devs life easier in many ways.
If you haven't used them yet, I can only recommend reading the
[official docs](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)
or my [blog post](@/blog/godot-custom-resources.md) about them.

Now I use them a lot, especially in **bigger projects** with many different data models.
At some point, you might want to duplicate a resource using the duplicate() method.
Here things got complicated for me.  
Reading the documentation would have saved me hours of debugging, and writing this blog post.
But I didn't expect that their duplicate() method works much different as in other object oriented programming languages.

The full source code in this article can be found on
[Coderberg](https://codeberg.org/dulvui/simondalvai.org/src/branch/main/sandbox/duplicate-resources/)
and on [Github](https://github.com/dulvui/simondalvai.org/src/branch/main/sandbox/duplicate-resources/).

Note: This blog post was written using **Godot 4.x** (version 4.4 to be precise) and things could break with further versions.

## Create custom resources
I will simply reuse some reduced resources from my open-source game [99 Managers Futsal Edition](@/games/99managers-futsal-edition/index.md).
There we have **futsal players** with a name and surname.
(For who doesn't know [Futsal](https://en.wikipedia.org/wiki/Futsal) yet, it's 5 a side soccer indoors)
```gd
class_name Player
extends Resource

@export var name: String
@export var surname: String

# custom resources need a _init() method with default values
# to work as expected inside Godot
func _init(
    p_name: String = "",
    p_surname: String = "",
) -> void:
    name = p_name
    surname = p_surname
```
Let's see how Resources can be duplicated in Godot.

## Simple references
The most trivial way to make two resources from one, is to assign it to a new variable.
```gd
var player_1: Player = Player.new("Gianluigi", "Buffon")
var player_2: Player = player_1
```
This creates a **reference** of the resource that still points to the same resource and **no duplication** takes place.
This can be useful if you want to keep a pointer to a nested resource for easier access.

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
This function is also present in other classes, like Dictionary and Array.

To show how duplicate works, a more complicated resource is needed.
So let's create a team with a goalkeeper, that is a player.
```gd
class_name Team
extends Resource

@export var name: String
@export var goalkeeper: Player
@export var field_players: Array[Player]

func _init(
    p_name: String = "",
    p_goalkeeper: Player = Player.new(),
    p_field_players: Array[Player] = [],
) -> void:
    name = p_name
    goalkeeper = p_goalkeeper
    field_players = p_field_players
```
**Important** to know is that only resources with the **@export** annotation get deeply duplicated.
Additionally, this method will fail if **_init()** has been defined with **required parameters**.

Now let's create a team and see how it duplicates.
```gd
# Let's instantiate a team with a goalkeeper
var team_1: Team = Team.new("Italy", Player.new("Gianluigi", "Buffon"))
# and a copy of it
var team_2: Team = team_1.duplicate()

team_2.name = "Italy copy"
# True, because both teams are unique and independent resources
assert(team_1.name != team_2.name)

# Let's change team_2's goalkeeper name
team_2.goalkeeper.name = "Ganluigi"
# True, because both are named Gianluigi
assert(team_1.goalkeeper.name == team_2.goalkeeper.name)

# Let's change team_2's goalkeeper surname
team_2.goalkeeper.surname = "Donnarumma"
# Also true, because the team_2's goalkeeper is a reference of the team_1's goalkeeper
assert(team_1.goalkeeper.surname == team_2.goalkeeper.surname)
```
So duplicate() creates a **unique and independent resources**, but all sub-resources will be **shallow copies**.
This means they are only references.

## Deep copy with duplicate(true)
The duplicate method has a boolean parameter called **subresources**, if set true, all sub-resources are also duplicated.
So when using the same code from the previous section, the goalkeeper will also be duplicated.
```gd
# Let's instantiate a team with a goalkeeper
var team_1: Team = Team.new("Italy", Player.new("Gianluigi", "Buffon"))
# and a copy of it, with sub-resources set to true
var team_2: Team = team_1.duplicate(true)

team_2.name = "Italy copy"
# Still true, because both teams are unique and independent resources
assert(team_1.name != team_2.name)

team_2.goalkeeper.name = "Gianluigi"
# True, because both still are named Gianluigi
assert(team_1.goalkeeper.name == team_2.goalkeeper.name)

team_2.goalkeeper.surname = "Donnarumma"
# True, because the team_2's goalkeeper NO LONGER is a reference of the team_1's goalkeeper
assert(team_1.goalkeeper.surname != team_2.goalkeeper.surname)
```

## Real deep copy
Great, we can now duplicate resources now with all properties.
Well, actually **not all of them**.  
The documentation reads: "Subresources inside Array and Dictionary properties are **never** duplicated."
So there is currently no way to deeply duplicate a resource, with ALL it's sub-resources, using Godot's methods.
```gd
# Lets create once again two players
var goalkeeper: Player = Player.new("Gianluigi", "Buffon")
var player_1: Player = Player.new("Paolo", "Maldini")
var player_2: Player = Player.new("Alessandro", "Del Piero")
# and a team with the two players
var team_1: Team = Team.new("Italy", goalkeeper, [player_1, player_2])
```

Now we have a resource (team) with an Array of sub-resources (players).
Let's make some tests.
```gd
var team_2: Team = team_1.duplicate(true)
team_2.name = "Italy copy"
# lets change a players name
team_2.players[0].name = "Daniele"
# True
assert(team_1.surname != team_2.surname)
# True, because both player arrays still are the same resource
assert(team_1.players[0].name == team_2.players[0].name)
```

So let's create a custom method to cover this special case.
```gd
func duplicate_deep() -> Team:
	var copy: Team = duplicate(true)
	copy.players = []
	for player: Player in field_players:
		copy.players.append(player.duplicate(true))
	return copy
```
Using this custom duplicate_deep() method, the tests from above will work as expected.
The same approach works with Dictionaries.
```gd
var team_deep: Team = team_1.duplicate_deep()
team_deep.name = "Italy copy"
# lets change a players surname
team_deep.players[0].name = "Daniele"
# True
assert(team_1.surname != team_deep.surname)
# True, because both players are unique resources
assert(team_1.players[0].name != team_deep.players[0].name)
```
Here you can find the
[official documentation](https://docs.godotengine.org/en/stable/classes/class_resource.html#class-resource-method-duplicate)
of the duplicate method.

## In the meantime, my code changed
When I started writing this, I had the necessity to deeply duplicate resources.
In the meantime I refactored parts of the code to **avoid using duplicates**.  
This makes everything a lot easier to understand and to maintain.
I still want to share how it is possible, but highly recommend to check twice **if it is really needed**.

Said that, I also highly recommend to read the [**official documentation**](https://docs.godotengine.org/en/stable/), as much as possible.
Godot has a really amazing documentation, with the class reference also included offline in the editor.
So even with no/low internet connections, you are covered.  
And to be honest, if I should have read the duplicate methods documentation better in the first place.

## Summary
So the most important things to keep in mind when duplicating resources are
- **_init()** with default parameters
- Only **@export** annotated properties get duplicated
- **duplicate()** creates copy of built-in properties, but references to sub-resources
- **duplicate(true)** creates copy of all properties also sub-resources, except Arrays and Dictionaries
- A **custom method** is needed, to duplicate Arrays and Dictionaries
