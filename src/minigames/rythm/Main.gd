extends Node

# Cuenta atrás e inicio del juego
var current_countdown = 4
var game_started = false

# Constante velocidad (nº de ticks para bajar las piezas)
const speed_ticks = 20

var counter = 0 # Dentro de la lista notes_queue, qué elemento coger despues
var left = 0 # Cuantos ticks quedan antes pasar al siguiente elemento de la lista notes_queue

# Lo mismo, pero unos pocos ticks adelantado para colocar las piezas fuera de la pantalla
var counter_pieces = 1
var left_pieces = 0

var notes_queue = [] # Array de notas a tocar durante la partida
# El formato de cada uno de los elementos del array anterior es el siguiente:
#  - Hay dos elementos
#  - El primero de estos elementos indica el tiempo en ticks que deben durar las notas
#  - El segundo es un array con los números de las notas a reproducir (números en base a la posición en el array "files" en tonos.json)

var notes # Referencia para obtener los nombres de los archivos de las notas y los acordes.
var tempo # Segundos por TICK

# Variables para que el kick y la caja se intercalen
var next_kick = true
var next_drum = true

# Constantes de la posición de los objetos en la pantalla (px)
const bar_distance = 750
const bar_height = 20
const piece_height = 50

# FIXME Cambiar por los valores reales de tamaño
const vheight = 1280
const vwidth = 960

# Array of rects currently on screen.
const rects = []

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
	# Nos llevó 25 minutos descubrir esta ecuación. No caigas en el mismo error de tratar de entenderla.
	# PD: La barra tiene que empezar en y = -piece_height
	speed = (bar_distance + (piece_height/2.0) - bar_height) / (speed_ticks * tempo)
	prepare_queues()


func new_rect(posx, posy=(-piece_height), sizey=50, sizex=200):
	var new_rect = ColorRect.new()
	$Background.add_child(new_rect)
	new_rect.rect_position.x = posx
	new_rect.rect_position.y = posy
	new_rect.rect_size.x = sizex
	new_rect.rect_size.y = sizey
	rects.append(new_rect)


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

func play_sound_mk2(sound_name): # Lo mismo que arriba, pero por segunda vez para poder reproducir dos a la vez.
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
		for rect in rects:
			rect.rect_position.y = rect.rect_position.y + speed * delta

func time_tick():
	if current_countdown != 5:
		count_down()
	else:
		play_drum()
		handle_notes()
		handle_pieces()

func handle_notes():
	if left == 0:
		if counter >= notes_queue.size():
			print("MINIJUEGO FINALIZADO")
			# DEBUG FIXME TODO: SOLO DE MOMENTO PARA EL DESARROLLO QUITAR LUEGO POR FAVOR NO OLVIDARSE
			# Ole, muy buen recordatorio jaja ↑
			get_tree().quit()
			return

		var _queue_element = notes_queue[counter]
		counter += 1

		left = _queue_element[0]
		var _notes = _queue_element[1]

		for x in _notes:
			play_piano(x)
	else:
		left -= 1

func handle_pieces():
	if left_pieces == 0:
		if counter_pieces >= notes_queue.size():
			return

		var _queue_element = notes_queue[counter_pieces]
		counter_pieces += 1

		left_pieces = _queue_element[0]
		var _notes = _queue_element[1]

		for x in _notes:
			new_rect((vwidth / 5.0) * (int(x) % 4))
	else:
		left_pieces -= 1
	

func prepare_queues():
	var previous_note = 2
	notes_queue.append([speed_ticks, []])
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
	print(notes_queue)
