# SPDX-FileCopyrightText: 2025 Simon Dalvai <info@simondalvai.org>
#
# SPDX-License-Identifier: MIT

extends Node

func _ready() -> void:
	print("duplication test suite starting...")
	
	test_references()
	test_duplicate()
	test_duplicate_true()
	test_duplicate_deep()

	print("duplication test suite done.")

	# quit after tests are done
	get_tree().quit()


func test_references() -> void:
	print("testing references...")
	
	var player_1: Player = Player.new("Gianluigi", "Buffon")
	var player_2: Player = player_1

	# True, since both have the same RIDs
	assert(player_1.get_rid() == player_2.get_rid())

	# changing player_1's properties, will automatically also change player_2's properties
	player_1.name = "Alessandro"
	player_1.surname = "Del Piero"
	# True, because both variables point to the changed resource
	assert(player_1.surname == player_2.surname)
	
	print("testing references done.")


func test_duplicate() -> void:
	print("testing duplicate...")

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
	
	print("testing duplicate done.")


func test_duplicate_true() -> void:
	print("testing duplicate(true)...")

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
	
	print("testing duplicate(true) done.")


func test_duplicate_deep() -> void:
	print("testing duplicate deep...")

	var goalkeeper: Player = Player.new("Gianluigi", "Buffon")
	var player_1: Player = Player.new("Paolo", "Maldini")
	var player_2: Player = Player.new("Alessandro", "Del Piero")
	# and a team with the two players
	var team_1: Team = Team.new("Italy", goalkeeper, [player_1, player_2])

	var team_2: Team = team_1.duplicate(true)
	team_2.name = "Italy copy"
	# lets change a players name
	team_2.field_players[0].name = "Daniele"
	# True
	assert(team_1.name != team_2.name)
	# True, because both player arrays still are the same resource
	assert(team_1.field_players[0].name == team_2.field_players[0].name)

	# lets revert the players name
	team_1.field_players[0].name = "Paolo"

	# using duplicate_deep
	var team_deep: Team = team_1.duplicate_deep()
	team_deep.name = "Italy deep copy"
	# lets change a players surname
	team_deep.field_players[0].name = "Daniele"
	# True
	assert(team_1.name != team_2.name)
	# True
	assert(team_1.field_players[0].surname == team_deep.field_players[0].surname)
	# True, because both players are unique resources
	assert(team_1.field_players[0].name != team_deep.field_players[0].name)

	print("testing duplicate deep done.")
