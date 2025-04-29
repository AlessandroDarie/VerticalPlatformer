extends Button

@onready var click_sound = $sfx_button
const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	if text == "Base":
		text = "BASE BUTTON"
	connect("pressed", Callable(self, "_on_button_pressed"))


func _on_button_pressed():
	print("Bottone premuto!")
	if click_sound:
		print("Click sound trovato, provo a suonarlo...")
		click_sound.play()
	else:
		print("Errore: click_sound è null")
