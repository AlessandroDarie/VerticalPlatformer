extends Node2D

var is_game_over = false

var base_time_scale = 1.0
var time_increment = 0.025
var score_step = 75
var last_steps = 0
var max_time_scale = 3.0

func set_game_over():
	is_game_over = true
	Engine.time_scale = 1.0
	if has_node("ScoreUI/Button (Pause)"):
		$"ScoreUI/Button (Pause)".disabled = true
		$"ScoreUI/Button (Pause)".visible = false

func _process(delta):
	if not is_game_over:
		update_time_scale()

func update_time_scale():
	if has_node("ScoreUI"):
		var score_ui = get_node("ScoreUI")
		if score_ui.has_node("Label"):
			var score_text = score_ui.get_node("Label").text
			var score = int(score_text.replace("Punteggio: ", ""))
			var steps = score / score_step
			if steps > last_steps:
				last_steps = steps
				Engine.time_scale = base_time_scale + (steps * time_increment)
				if Engine.time_scale > max_time_scale:
					Engine.time_scale = max_time_scale
				print("Time scale increased! New time_scale:", Engine.time_scale)


func _on_button_pause_pressed():
	$PauseUI.show_pause()
