extends Control

func _on_button_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main.tscn")


func _on_button_quit_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_button_play_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main.tscn")
