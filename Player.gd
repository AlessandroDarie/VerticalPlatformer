extends CharacterBody2D

var speed = 400.0
var jump_velocity = -800.0
var gravity = 900.0
var is_ready_to_jump = false

var move_left = false
var move_right = false

func _physics_process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		is_ready_to_jump = true

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
