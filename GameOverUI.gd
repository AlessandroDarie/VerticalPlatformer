extends CanvasLayer
const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	visible = false

func show_game_over():
	visible = true

func _on_button_restart_pressed():
	get_tree().reload_current_scene()


func _on_button_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
