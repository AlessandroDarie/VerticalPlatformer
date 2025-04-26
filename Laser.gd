extends Node2D

@export var speed: float = 100.0
@export var player: NodePath

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))

func _process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return

	if player:
		var player_node = get_node(player)
		
	global_position.y -= speed * delta

func _on_area2d_body_entered(body):
	if body.name == "Player":
		var main = get_tree().get_root().get_node("Main")
		main.set_game_over()
		
		var ui = main.get_node("GameOverUI")
		ui.show_game_over()
