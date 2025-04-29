extends CanvasLayer

@export var player: NodePath

var max_height = 0
var highscore = 0

var coins_in_game = 0
var coins_total = 0

const VolumeManager = preload("res://Managers/VolumeManager.gd")

func _ready():
	VolumeManager.load_volume_settings(get_tree().get_root())
	max_height = 0
	load_highscore()
	load_coins()

func _process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return

	if player:
		var player_node = get_node(player)
		var current_height = int(((-player_node.global_position.y)-30) / 10)
		
		if current_height > max_height:
			max_height = current_height
			$Label.text = "Score: " + str(max_height)
			
			if max_height > highscore:
				highscore = max_height
				save_highscore()

	var main = get_tree().get_root().get_node("Main")
	if main:
		$CoinsTotalLabel.text = "" + str(coins_total)

func load_highscore():
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		highscore = int(file.get_line())
		file.close()
	
	$RecordLabel.text = "Record: " + str(highscore)

func save_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_line(str(highscore))
	file.close()

func load_coins():
	if FileAccess.file_exists("user://coins.save"):
		var file = FileAccess.open("user://coins.save", FileAccess.READ)
		coins_total = int(file.get_line())
		file.close()

func save_coins():
	var file = FileAccess.open("user://coins.save", FileAccess.WRITE)
	file.store_line(str(coins_total))
	file.close()

func increment_coins():
	coins_in_game += 1
	coins_total += 1
	save_coins()
