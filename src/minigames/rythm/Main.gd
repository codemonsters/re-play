extends Node

var current_countdown = 4
var game_started = false

func _ready():
	$Background/Countdown.hide()
	count_down()

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

func play_piano():
	var a4 = load("res://assets/ogg notes/a4.ogg")
	print("Loop: " + str(a4.has_loop()))
	a4.set_loop(false)
	$AudioStreamPlayer2D.set_stream(a4)
	$AudioStreamPlayer2D.play()

func start_game():
	$Background/Countdown.hide()
	play_piano()
	game_started = true
	
func _process(delta):
	pass
