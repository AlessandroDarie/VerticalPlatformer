extends Node

@onready var click_sound = preload("res://assets/audio/interface/Audio/maximize_006.ogg")
# @onready var hover_sound = preload("res://assets/audio/hover.wav")

func _ready():
	name = "SoundManager"
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_owner(get_tree().get_root())
	get_tree().get_root().add_child(self)

func play_click():
	var player = AudioStreamPlayer.new()
	player.stream = click_sound
	add_child(player)
	player.play()
	player.connect("finished", Callable(player, "queue_free"))
