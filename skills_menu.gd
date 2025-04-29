extends Control

const VolumeManager = preload("res://Managers/VolumeManager.gd")
const SkillsData = preload("res://Skills/SkillsData.gd")

@onready var skill_boxes = [
	$skill_box,
	$skill_box2,
	$skill_box3,
	$skill_box4,
	$skill_box5,
	$skill_box6,
	$skill_box7
]

var coins_total = 0
var saved_levels := {}

@onready var coins_label = $CoinsTotalLabel

func _ready():
	load_coins()
	load_skill_levels()
	update_coins_label()
	VolumeManager.load_volume_settings(get_tree().get_root())
	var skills = SkillsData.SKILLS

	for i in skill_boxes.size():
		if i >= skills.size():
			skill_boxes[i].visible = false
			continue

		var data = skills[i]
		var box = skill_boxes[i]
		var level = saved_levels.get(data.id, 0)
		box.setup(data, coins_total, level)
		box.coins_changed.connect(_on_coins_changed)
		box.level_changed.connect(_on_skill_level_changed)

func _on_button_menu_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")

func load_coins():
	if FileAccess.file_exists("user://coins.save"):
		var file = FileAccess.open("user://coins.save", FileAccess.READ)
		coins_total = int(file.get_line())
		file.close()

func update_coins_label():
	coins_label.text = str(coins_total)
	
func _on_coins_changed(new_total: int):
	coins_total = new_total
	update_coins_label()
	save_coins()
	
func save_coins():
	var file = FileAccess.open("user://coins.save", FileAccess.WRITE)
	file.store_line(str(coins_total))
	file.close()
	
func load_skill_levels():
	var config = ConfigFile.new()
	var err = config.load("user://skills.save")
	if err == OK:
		saved_levels = {}
		var keys = config.get_section_keys("levels")
		for key in keys:
			saved_levels[key] = config.get_value("levels", key)
	else:
		saved_levels = {}

func _on_skill_level_changed(id: String, new_level: int):
	var config = ConfigFile.new()
	var path = "user://skills.save"
	var err = config.load(path)
	if err != OK:
		config.set_value("levels", id, new_level)
	else:
		config.set_value("levels", id, new_level)
	config.save(path)
