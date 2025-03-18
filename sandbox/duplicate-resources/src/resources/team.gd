# SPDX-FileCopyrightText: 2025 Simon Dalvai <info@simondalvai.org>
#
# SPDX-License-Identifier: MIT

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


func duplicate_deep() -> Team:
	var copy: Team = duplicate(true)
	copy.field_players = []
	for player: Player in field_players:
		copy.field_players.append(player.duplicate(true))
	return copy
