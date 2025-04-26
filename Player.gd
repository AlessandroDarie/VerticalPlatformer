extends CharacterBody2D

var speed = 200.0
var jump_velocity = -800.0
var gravity = 900.0

func _physics_process(delta):
	# Applichiamo la gravità
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Movimento orizzontale
	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_direction * speed

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Muove il player e gestisce le collisioni
	move_and_slide()

func _on_area_entered(area):
	print("Player entered area:", area.name)
