extends Control

const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())


func _on_button_menu_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
