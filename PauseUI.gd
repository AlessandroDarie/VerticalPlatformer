extends CanvasLayer

const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	visible = false

func show_pause():
	visible = true
	get_tree().paused = true

func hide_pause():
	visible = false
	get_tree().paused = false

func _on_button_continue_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()


func _on_button_restart_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()
	get_tree().reload_current_scene()


func _on_button_options_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://OptionsMenu.tscn")


func _on_button_menu_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()
	get_tree().change_scene_to_file("res://main_menu.tscn")
