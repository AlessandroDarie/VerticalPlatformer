extends Node2D

@export var platform_scene: PackedScene

var platform_gap = 750  # distanza tra piattaforme generate

func on_platform_reached(current_platform_y):
	var new_platform = platform_scene.instantiate()
	add_child(new_platform)

	var x_position = randf_range(-150, 150)  # posizione random su X
	var y_position = current_platform_y - platform_gap  # più in alto

	new_platform.global_position = Vector2(x_position, y_position)
