extends Node2D

@export var platform_scene: PackedScene
@export var coin_scene: PackedScene

var platform_gap = 750
var last_coin_spawn_score = 0
var coin_spawn_step = 1000

func on_platform_reached(current_platform_y):
	var new_platform = platform_scene.instantiate()
	add_child(new_platform)

	var screen_width = 480
	var half_width = screen_width / 2 - 60
	var x_position = randf_range(-half_width, half_width)
	var y_position = current_platform_y - platform_gap

	new_platform.global_position = Vector2(x_position, y_position)
	spawn_coin(y_position)
	
func spawn_coin(y_reference):
	var main = get_tree().get_root().get_node("Main")
	if main == null:
		return

	var score_ui = main.get_node("ScoreUI")
	if score_ui == null:
		return

	var score_text = score_ui.get_node("Label").text
	var score = int(score_text.replace("Punteggio: ", ""))

	# Spawna una sola moneta ogni 1000 punti
	if score >= last_coin_spawn_score + coin_spawn_step:
		last_coin_spawn_score = score

		var coin = coin_scene.instantiate()
		var screen_width = 480
		var half_width = screen_width / 2 - 40

		var x_position = randf_range(-half_width, half_width)
		var y_position = y_reference - randf_range(100, 300)

		coin.global_position = Vector2(x_position, y_position)
		add_child(coin)
