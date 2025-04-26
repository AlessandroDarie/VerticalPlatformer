extends StaticBody2D

var touched = false
var activated = false

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	await get_tree().create_timer(0.1).timeout
	activated = true

func _on_area2d_body_entered(body):
	if body.name == "Player" and not touched and activated:
		touched = true
		print("Player touched platform at height: ", global_position.y)
		var spawner = get_tree().get_root().get_node("Main/PlatformSpawner")
		spawner.on_platform_reached(global_position.y)
