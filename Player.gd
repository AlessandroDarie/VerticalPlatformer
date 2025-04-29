extends CharacterBody2D

var speed = 400.0
var jump_velocity = -800.0
var gravity = 900.0
var is_ready_to_jump = false

var move_left = false
var move_right = false

@onready var jump_sound = $sfx_JumpSound
@onready var jump_sound_2 = $sfx_JumpSound2
@onready var fall_sound = $sfx_FallSound
var last_jump_sound = 0
var jump_start_y = 0.0
var is_falling_sound_played = false

const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())

func _physics_process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y > 0:
			var fallen_distance = global_position.y - jump_start_y
			if fallen_distance > 200 and not is_falling_sound_played:
				if fall_sound:
					fall_sound.play()
					is_falling_sound_played = true

	else:
		velocity.y = 0
		is_ready_to_jump = true
		is_falling_sound_played = false

	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if move_right:
		input_direction += 1
	if move_left:
		input_direction -= 1
		
	velocity.x = input_direction * speed
	
	var screen_width = 480
	if global_position.x < -screen_width / 2:
		global_position.x = screen_width / 2
	elif global_position.x > screen_width / 2:
		global_position.x = -screen_width / 2

	if is_ready_to_jump:
		velocity.y = jump_velocity
		is_ready_to_jump = false
		jump_start_y = global_position.y
		is_falling_sound_played = false
		if last_jump_sound == 0:
			if jump_sound:
				jump_sound.play()
			last_jump_sound = 1
		else:
			if jump_sound_2:
				jump_sound_2.play()
			last_jump_sound = 0

	move_and_slide()

func _on_area_entered(area):
	print("Player entered area:", area.name)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var screen_center = get_viewport().get_visible_rect().size.x / 2
		if event.position.x < screen_center:
			move_left = true
			move_right = false
			print("Tocco a sinistra")
		else:
			move_right = true
			move_left = false
			print("Tocco a destra")

	if event is InputEventMouseButton and not event.pressed:
		move_left = false
		move_right = false
		print("Rilascio")
