extends Node

var current_countdown = 4
var game_started = false

var notes
var tempo # Segundos por beat

var next_kick = true
var next_drum = true

const assets_dir = "res://assets/"

func _ready():
	$Background/Countdown.hide()
	count_down()
	var notes_file = File.new()
	notes_file.open("res://assets/tonos.json", File.READ)
	notes = JSON.parse(notes_file.get_as_text()).result
	notes_file.close()
	randomize()
	tempo = rand_range(0.2, 0.25)

func count_down():
	$Background/Countdown.set_text(str(current_countdown))

	# Show the countdown after one second of blank
	if current_countdown == 3:
		$Background/Countdown.show()
		play_sound("intro.ogg")
	
	if current_countdown == 0:
		$Background/Countdown.set_text(str("GO!"))
	
	if current_countdown == -1:
		$Timer.stop()
		current_countdown = 5
		start_game()
	else:
		$Timer.start()
		current_countdown -= 1
 
func play_piano(note):
	play_sound("ogg notes/" + notes["files"][note])

func play_drum():
	if next_drum:
		if next_kick:
			play_sound("kick.ogg")
		else:
			play_sound("snare.ogg")
		next_kick = !next_kick
	next_drum = !next_drum

func play_sound(sound_name):
	var sound = load(assets_dir + sound_name)
	sound.set_loop(false)
	$AudioStreamPlayer.set_stream(sound)
	$AudioStreamPlayer.play()

func start_game():
	$Background/Countdown.hide()
	game_started = true
	$Timer.wait_time = tempo
	$Timer.start()
	
func _process(delta):
	pass

func time_tick():
	if current_countdown != 5:
		count_down()
	else:
		play_drum()
