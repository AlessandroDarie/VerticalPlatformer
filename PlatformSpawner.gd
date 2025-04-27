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
	
	var main = get_tree().get_root().get_node("Main")
	var score_ui = main.get_node("ScoreUI")
	var score_text = score_ui.get_node("Label").text
	var score = int(score_text.replace("Punteggio: ", ""))

	var shrink_factor = clamp(score / 5000.0, 0, 0.7)
	var base_width = 120.0

	if shrink_factor > 0:
		if new_platform.has_node("ColorRect"):
			var color_rect = new_platform.get_node("ColorRect")
			color_rect.size.x = base_width * (1.0 - shrink_factor)
			color_rect.position.x = -(color_rect.size.x / 2)

		if new_platform.has_node("CollisionShape2D"):
			var collision = new_platform.get_node("CollisionShape2D")
			if collision.shape is RectangleShape2D:
				var rect_shape = collision.shape
				rect_shape.size.x = base_width * (1.0 - shrink_factor)
				
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
