extends Node2D

@export var speed: float = 20.0  # velocità di salita
@export var player: NodePath  # per collegare il Player

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))

func _process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return
	global_position.y -= speed * delta
	
func _on_area2d_body_entered(body):
	if body.name == "Player":
		print("Game Over!")
		# Qui possiamo poi aggiungere anche cambio scena o popup
		var main = get_tree().get_root().get_node("Main")
		main.set_game_over()
		
		var ui = main.get_node("GameOverUI")
		ui.show_game_over()
