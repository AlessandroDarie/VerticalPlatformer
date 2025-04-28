extends Control

@onready var sfx_slider = $SFXVolumeSlider
@onready var music_slider = $MusicVolumeSlider
@onready var back_button = $Button_Back

func _ready():
	sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	music_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	
	sfx_slider.connect("value_changed", Callable(self, "_on_sfx_volume_changed"))
	music_slider.connect("value_changed", Callable(self, "_on_music_volume_changed"))
	back_button.connect("pressed", Callable(self, "_on_button_back_pressed"))

func _on_sfx_volume_changed(value):
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_bus, value)

func _on_music_volume_changed(value):
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, value)

func _on_button_back_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
