extends Node2D

@export var speed: float = 100.0
@export var player: NodePath

@onready var warning_sound = $WarningSound
@onready var hit_sound = $HitSound
const WARNING_START_DISTANCE = 500.0
const WARNING_STOP_DISTANCE = 1000.0
const MAX_VOLUME_DB = -20.0
const MIN_VOLUME_DB = -80.0
var is_warning_playing = false

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))

func _process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return

	if player:
		var player_node = get_node(player)
		var distance = global_position.distance_to(player_node.global_position)
		if distance < WARNING_START_DISTANCE:
			if warning_sound and not warning_sound.playing:
				warning_sound.play()
				is_warning_playing = true
			if warning_sound:
				warning_sound.volume_db = MAX_VOLUME_DB
		
		elif distance < WARNING_STOP_DISTANCE:
			if warning_sound:
				var t = (distance - WARNING_START_DISTANCE) / (WARNING_STOP_DISTANCE - WARNING_START_DISTANCE)
				warning_sound.volume_db = lerp(MAX_VOLUME_DB, MIN_VOLUME_DB, t)
		
		else:
			if warning_sound and warning_sound.playing:
				warning_sound.stop()
				is_warning_playing = false
		
	global_position.y -= speed * delta

func _on_area2d_body_entered(body):
	if body.name == "Player":
		if warning_sound and warning_sound.playing:
			warning_sound.stop()
		if hit_sound:
			hit_sound.play()
		var main = get_tree().get_root().get_node("Main")
		main.set_game_over()
		
		var ui = main.get_node("GameOverUI")
		ui.show_game_over()
