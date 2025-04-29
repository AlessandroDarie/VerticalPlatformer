extends Area2D

@onready var pickup_sound = $sfx_PickupSound
const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		var score_ui = get_tree().get_root().get_node("Main/ScoreUI")
		score_ui.increment_coins()
		
		if pickup_sound:
			pickup_sound.play()
		await get_tree().create_timer(0.3).timeout
			
		queue_free()
