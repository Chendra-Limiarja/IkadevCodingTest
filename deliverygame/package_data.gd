extends Node

const PACKAGE_TYPES = [
	{ "id": 0, "name": "Left Diagonal Box", "texture": preload("res://assets/sprites/packages/box.png"), "flip_h": false },
	{ "id": 1, "name": "Right Diagonal Box", "texture": preload("res://assets/sprites/packages/box.png"), "flip_h": true },
	{ "id": 2, "name": "X Box", "texture": preload("res://assets/sprites/packages/boxAlt.png"), "flip_h": false }
]

func get_random_package():
	return PACKAGE_TYPES[randi() % PACKAGE_TYPES.size()]
