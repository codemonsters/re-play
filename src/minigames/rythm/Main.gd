extends Node

var current_countdown = 4
var game_started = false

var notes
var tempo # Segundos por beat

func _ready():
	$Background/Countdown.hide()
	count_down()
	var notes_file = File.new()
	notes_file.open("res://assets/tonos.json", File.READ)
	notes = JSON.parse(notes_file.get_as_text()).result
	notes_file.close()
	randomize()
	tempo = rand_range(0.3, 0.5)

func count_down():
	$Background/Countdown.set_text(str(current_countdown))

	# Show the countdown after one second of blank
	if current_countdown == 3:
		$Background/Countdown.show()
	
	if current_countdown == 0:
		$Background/Countdown.set_text(str("GO!"))
	
	if current_countdown == -1:
		$Timer.stop()
		start_game()
	else:
		$Timer.start()
		current_countdown -= 1

func play_piano(note):
	print(notes["files"][note]) # DEBUG
	var note_sound = load("res://assets/ogg notes/" + notes["files"][note])
	note_sound.set_loop(false)
	$AudioStreamPlayer.set_stream(note_sound)
	$AudioStreamPlayer.play()

func start_game():
	$Background/Countdown.hide()
	play_piano(5)
	game_started = true
	
func _process(delta):
	pass
