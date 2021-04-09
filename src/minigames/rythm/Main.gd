extends Node

# Cuenta atrás e inicio del juego
var current_countdown = 4
var game_started = false

var counter = 0 # Dentro de la lista notes_queue, que elemento coger despues
var left = 0 # Cuantos ticks quedan antes pasar al siguiente elemento de la lista notes_queue

var notes_queue = [] # Array de notas a tocar durante la partida
# El formato del array anterior es el siguiente:
#  - Cada elemento es un array (dos elementos)
#  - El primero de estos elementos indica el tiempo en ticks que deben durar las notas
#  - El segundo es un array con los números de las notas a reproducir (números en base a la posición en el array "files" en tonos.json)

var rectangles_queue = []
# El formato del array anterior es el siguiente (dos elementos):
#  - El primero de estos elementos indica la altura del rectángulo
#  - El segundo indica el tiempo en ticks desde el inicio de la partida que deben pasar antes de posicionar el rectángulo a punto de entrar en pantalla
# NOTA: Los rectángulos tardan 4 ticks en bajar desde que aparece su primer pixel hasta que tienen que sonar

var notes # Referencia para obtener los nombres de los archivos de las notas y los acordes.
var tempo # Segundos por beat

# Variables para que el kick y la caja se intercalen
var next_kick = true
var next_drum = true

const assets_dir = "res://assets/"

func _ready():
	$Background/Countdown.hide()
	count_down()
	var notes_file = File.new()
	notes_file.open(assets_dir + "tonos.json", File.READ)
	notes = JSON.parse(notes_file.get_as_text()).result
	notes_file.close()
	randomize()
	tempo = rand_range(0.2, 0.25)
	prepare_queues()

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

func prepare_queues():
	for chord_num in range(5):
		randomize()
		var chord = notes["chords"][randi() % notes["chords"].size()]
		for beat_num in range(2):
			randomize()
			var various_notes = true if randi() % 2 else false
			var time = 2 if various_notes else 1
			for note_num in range(time):
				randomize()
				var _notes = []
				var _simultaneous_rand = randi() % 9
				var _simultaneous_notes = 1
				if _simultaneous_rand < 2:
					_simultaneous_notes = 3
				elif _simultaneous_rand < 4:
					_simultaneous_notes = 2
				for simultaneous_num in range(_simultaneous_notes):
					randomize()
					var _note = chord[randi() % chord.size()]
					if !_notes.has(_note):
						_notes.append(_note)
				notes_queue.append([time, _notes])

	print(notes_queue)

