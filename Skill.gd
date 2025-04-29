extends Control

signal coins_changed(new_total: int)
signal level_changed(id: String, new_level: int)

@onready var name_label = $NameLabel
@onready var level_label = $LevelLabel
@onready var cost_label = $CostLabel
@onready var icon = $Icon
@onready var increase_button = $ButtonPlus
@onready var decrease_button = $ButtonMinus

var skill_name = ""
var max_level = 10
var level = 0
var base_cost = 50
var current_cost = 50
var coins_total = 0
var skill_id = ""

@onready var success_sound = $SuccessSound
@onready var fail_sound = $FailSound

func setup(data: Dictionary, total_coins: int, start_level := 0):
	skill_name = data.get("name", "Skill")
	skill_id = data.get("id", "")
	max_level = data.get("max_level", 10)
	base_cost = data.get("base_cost", 50)
	level = start_level
	current_cost = int(base_cost * pow(1.2, level))
	coins_total = total_coins

	if data.has("icon"):
		icon.texture = data.icon

	update_ui()

func update_ui() -> void:
	name_label.text = skill_name

	if level >= max_level:
		level_label.text = "MAX"
		increase_button.disabled = true
	else:
		level_label.text = "Lv. %d" % level
		increase_button.disabled = false

	if level == 0:
		decrease_button.disabled = true
	else:
		decrease_button.disabled = false

	# Aggiorna costo
	cost_label.text = "%d" % current_cost

func _on_button_plus_pressed() -> void:
	if level >= max_level:
		play_fail_sound()
		return

	if coins_total >= current_cost:
		play_success_sound()
		level += 1
		coins_total -= current_cost
		emit_signal("coins_changed", coins_total)
		emit_signal("level_changed", skill_id, level)
		calculate_new_cost()
		update_ui()
	else:
		play_fail_sound()

func _on_button_minus_pressed() -> void:
	if level > 0:
		play_success_sound()
		level -= 1
		coins_total += previous_cost()
		emit_signal("coins_changed", coins_total)
		emit_signal("level_changed", skill_id, level)
		calculate_new_cost()
		update_ui()
	else:
		play_fail_sound()

func calculate_new_cost() -> void:
	current_cost = int(base_cost * pow(1.2, level))

func previous_cost() -> int:
	return int(base_cost * pow(1.2, level))
	
func play_success_sound() -> void:
	if success_sound:
		success_sound.play()

func play_fail_sound() -> void:
	if fail_sound:
		fail_sound.play()
