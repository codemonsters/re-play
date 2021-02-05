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


func start_game():
	$Background/Countdown.hide()
	game_started = true
	
func _process(delta):
	pass
