extends Node2D

@export var speed: float = 100.0
@export var player: NodePath

@onready var warning_sound = $sfx_WarningSound
@onready var hit_sound = $sfx_HitSound

const VolumeManager = preload("res://Managers/VolumeManager.gd")

const WARNING_START_DISTANCE = 500.0
const WARNING_STOP_DISTANCE = 1000.0
const MAX_VOLUME_DB = 0.0
const MIN_VOLUME_DB = -60.0

var is_warning_playing = false
var warning_base_volume = 0.0

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	if warning_sound:
		warning_base_volume = warning_sound.volume_db
	
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
				warning_sound.volume_db = warning_base_volume + MAX_VOLUME_DB
		
		elif distance < WARNING_STOP_DISTANCE:
			if warning_sound:
				var t = (distance - WARNING_START_DISTANCE) / (WARNING_STOP_DISTANCE - WARNING_START_DISTANCE)
				warning_sound.volume_db = warning_base_volume + lerp(MAX_VOLUME_DB, MIN_VOLUME_DB, t)
		
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
