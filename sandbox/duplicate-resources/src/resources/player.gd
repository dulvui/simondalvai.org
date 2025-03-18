# SPDX-FileCopyrightText: 2025 Simon Dalvai <info@simondalvai.org>
#
# SPDX-License-Identifier: MIT

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

