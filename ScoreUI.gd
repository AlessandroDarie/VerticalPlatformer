extends CanvasLayer

@export var player: NodePath  # Colleghiamo il Player

var max_height = 0  # Altezza massima raggiunta
var highscore = 0   # Record salvato

func _ready():
	max_height = 0
	load_highscore()

func _process(delta):
	if get_tree().get_root().get_node("Main").is_game_over:
		return  # Se è Game Over non aggiorniamo più

	if player:
		var player_node = get_node(player)
		# Siccome Y diminuisce salendo, usiamo -Y
		var current_height = int(-player_node.global_position.y / 10) - 3
		
		if current_height > max_height:
			max_height = current_height
			$Label.text = "Punteggio: " + str(max_height)
			
			if max_height > highscore:
				highscore = max_height
				save_highscore()

func load_highscore():
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		highscore = int(file.get_line())
		file.close()
	
	# Aggiorna subito il testo del record
	$RecordLabel.text = "Record: " + str(highscore)


func save_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_line(str(highscore))
	file.close()
