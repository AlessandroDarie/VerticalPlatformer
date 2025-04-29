extends Control

const VolumeManager = preload("res://Managers/VolumeManager.gd")

@onready var sfx_slider = $SFXVolumeSlider
@onready var music_slider = $MusicVolumeSlider
@onready var back_button = $Button_Back

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err == OK:
		sfx_slider.value = config.get_value("audio", "sfx_volume", 0)
		music_slider.value = config.get_value("audio", "music_volume", 0)
	else:
		sfx_slider.value = 0
		music_slider.value = 0

	_adjust_audio_volume("sfx", sfx_slider.value)
	_adjust_audio_volume("music", music_slider.value)
	
	sfx_slider.connect("value_changed", Callable(self, "_on_sfx_slider_value_changed"))
	music_slider.connect("value_changed", Callable(self, "_on_music_slider_value_changed"))


func _on_sfx_slider_value_changed(value):
	_adjust_audio_volume("sfx", value)
	_save_volume_settings()

func _on_music_slider_value_changed(value):
	_adjust_audio_volume("music", value)
	_save_volume_settings()

func _adjust_audio_volume(tag: String, value: float):
	var root = get_tree().get_root()
	_set_volume_recursive(root, tag, value)

func _set_volume_recursive(node: Node, tag: String, value: float):
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		if node.name.to_lower().begins_with(tag):
			node.volume_db = value
	for child in node.get_children():
		_set_volume_recursive(child, tag, value)

func _on_button_back_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
func _save_volume_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "sfx_volume", sfx_slider.value)
	config.set_value("audio", "music_volume", music_slider.value)
	
	config.save("user://settings.cfg")
