extends CanvasLayer

func _ready():
	visible = false  # all'inizio invisibile

func show_game_over():
	visible = true

func _on_button_riprova_pressed():
	get_tree().reload_current_scene()  # ricarica la scena principale
