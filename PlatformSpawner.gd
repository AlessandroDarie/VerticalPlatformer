extends Node2D

@export var platform_scene: PackedScene

var platform_gap = 750  # distanza tra piattaforme generate

func on_platform_reached(current_platform_y):
	var new_platform = platform_scene.instantiate()
	add_child(new_platform)

	var screen_width = 480
	var half_width = screen_width / 2 - 60
	var x_position = randf_range(-half_width, half_width)
	var y_position = current_platform_y - platform_gap

	new_platform.global_position = Vector2(x_position, y_position)
