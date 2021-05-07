extends Node

# Cuenta atrás e inicio del juego
var current_countdown = 4
var game_started = false

var counter = 0 # Dentro de la lista notes_queue, que elemento coger despues
var left = 0 # Cuantos ticks quedan antes pasar al siguiente elemento de la lista notes_queue

var notes_queue = [] # Array de notas a tocar durante la partida
# El formato del array anterior es el siguiente:
#  - Hay dos elementos
#  - El primero de estos elementos indica el tiempo en ticks que deben durar las notas
#  - El segundo es un array con los números de las notas a reproducir (números en base a la posición en el array "files" en tonos.json)

var rectangles_queue = []
# El formato del array anterior es el siguiente (dos elementos):
#  - El primero de estos elementos indica la altura del rectángulo
#  - El segundo indica el tiempo en ticks desde el inicio de la partida que deben pasar antes de posicionar el rectángulo a punto de entrar en pantalla
# NOTA: Los rectángulos tardan 4 ticks en bajar desde que aparece su primer pixel hasta que tienen que sonar

var notes # Referencia para obtener los nombres de los archivos de las notas y los acordes.
var tempo # Segundos por TICK

# Variables para que el kick y la caja se intercalen
var next_kick = true
var next_drum = true

# Constantes de la posición de los objetos en la pantalla (px)
const bar_distance = 750
const bar_height = 20
const piece_height = 50

# Constante velocidad (nº de ticks para bajar las piezas)
const speed_ticks = 20

var speed

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
	speed = (bar_distance+((piece_height)/2)-bar_height)/(speed_ticks*tempo) # Nos llevó 25 minutos descubrir esta ecuación. No caigas en el mismo error de tratar de entenderla.
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
	play_sound_mk2("ogg notes/" + notes["files"][note])

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

func play_sound_mk2(sound_name):
	var sound = load(assets_dir + sound_name)
	sound.set_loop(false)
	$AudioStreamPlayer2.set_stream(sound)
	$AudioStreamPlayer2.play()

func start_game():
	$Background/Countdown.hide()
	game_started = true
	$Timer.wait_time = tempo
	$Timer.start()
	
func _process(delta):
	if game_started:
		$Background/ColorRect.rect_position.y = $Background/ColorRect.rect_position.y+speed*delta

func time_tick():
	if current_countdown != 5:
		count_down()
	else:
		play_drum()
		handle_notes()

func handle_notes():
	if left == 0:
		if counter >= notes_queue.size():
			print("MINIJUEGO FINALIZADO")
			# DEBUG FIXME TODO: SOLO DE MOMENTO PARA EL DESARROLLO QUITAR LUEGO POR FAVOR NO OLVIDARSE
			get_tree().quit()

		var _queue_element = notes_queue[counter]
		counter += 1

		left = _queue_element[0]
		var _notes = _queue_element[1]

		for x in _notes:
			play_piano(x)
	else:
		left -= 1

func prepare_queues():
	var previous_note = 2
	for chord_num in range(10):
		randomize()
		var chord = notes["chords"][randi() % notes["chords"].size()]
		for beat_num in range(2):
			randomize()
			var various_notes = true if randi() % 2 else false
			var time = 2 if various_notes else 1
			for note_num in range(time):
				randomize()
				var _notes = []
				for test in range(10):	
					var _note = chord[randi() % chord.size()]
					if abs(_note - previous_note) <= 2 and _note != previous_note:
						_notes.append(_note)
						break
				notes_queue.append([time, _notes])
				if _notes.size() > 0:
					previous_note = _notes[0]
	#print(notes_queue)

# FIXME: EN LA VERSION FINAL QUITAR LO SIGUIENTE. DE MOMENTO LO DEJAMOS POR SI ACASO PASA ALGO... 😜
func prepare_queues_old():
	for chord_num in range(10):
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

