extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		var score_ui = get_tree().get_root().get_node("Main/ScoreUI")
		score_ui.increment_coins()
		queue_free()
