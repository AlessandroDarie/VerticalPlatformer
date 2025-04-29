extends CanvasLayer

const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	visible = false

func show_pause():
	visible = true
	get_tree().paused = true
	
	var main = get_tree().get_root().get_node("Main")
	if main.has_node("ScoreUI/Button_Pause"):
		main.get_node("ScoreUI/Button_Pause").visible = false

func hide_pause():
	visible = false
	get_tree().paused = false
	
	var main = get_tree().get_root().get_node("Main")
	if main.has_node("ScoreUI/Button_Pause"):
		main.get_node("ScoreUI/Button_Pause").visible = true

func _on_button_continue_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()


func _on_button_restart_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()
	get_tree().reload_current_scene()

func _on_button_menu_pressed():
	await get_tree().create_timer(0.3).timeout
	hide_pause()
	get_tree().change_scene_to_file("res://main_menu.tscn")
