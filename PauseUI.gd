extends CanvasLayer

func _ready():
	visible = false

func show_pause():
	visible = true
	get_tree().paused = true

func hide_pause():
	visible = false
	get_tree().paused = false

func _on_button_continue_pressed():
	hide_pause()


func _on_button_restart_pressed():
	hide_pause()
	get_tree().reload_current_scene()


func _on_button_options_pressed():
	print("Options clicked!") # Placeholder


func _on_button_menu_pressed():
	hide_pause()
	get_tree().change_scene_to_file("res://main_menu.tscn")
