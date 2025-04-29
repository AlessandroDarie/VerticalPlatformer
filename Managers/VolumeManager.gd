
static func load_volume_settings(root: Node) -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err == OK:
		var sfx_volume = config.get_value("audio", "sfx_volume", 0.0)
		var music_volume = config.get_value("audio", "music_volume", 0.0)
		
		_adjust_audio_volume(root, "sfx", sfx_volume)
		_adjust_audio_volume(root, "music", music_volume)

static func _adjust_audio_volume(root: Node, tag: String, value: float) -> void:
	_set_volume_recursive(root, tag, value)

static func _set_volume_recursive(node: Node, tag: String, value: float) -> void:
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		if node.name.to_lower().begins_with(tag):
			if value <= -95.0:
				node.volume_db = -100.0
				node.stream_paused = true 
			else:
				node.stream_paused = false
				node.volume_db = value
	for child in node.get_children():
		_set_volume_recursive(child, tag, value)
