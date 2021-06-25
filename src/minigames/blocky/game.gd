extends Node2D

const ROWS = 12
const COLS = 12

onready var tetromino_l = preload("res://minigames/blocky/tetrominos/tetromino_l.tscn")
onready var tetromino_line = preload("res://minigames/blocky/tetrominos/tetromino_line.tscn")
onready var tetromino_s = preload("res://minigames/blocky/tetrominos/tetromino_s.tscn")
onready var tetromino_square = preload("res://minigames/blocky/tetrominos/tetromino_square.tscn")
onready var tetromino_t = preload("res://minigames/blocky/tetrominos/tetromino_t.tscn")
var available_tetrominos = [] # List of tetrominos available in the palette (right side of the screen)
var matrix = []
var line_color = Color(51.0 / 255.0, 255.0 / 255.0, 51.0 / 255.0)


func _ready():
	create_empty_blocks()
	fetch_new_tetrominos()


func create_empty_blocks():
	# initialize stage matrix
	var blockContainer = preload("res://minigames/blocky/block_container.tscn")

	var width = $Background/Stage.get_size().x
	var height = $Background/Stage.get_size().y

	for row in range(ROWS):
		matrix.append([])
		for col in range(COLS):
			var x = col * width / COLS + width / (2 * COLS)
			var y = row * height / ROWS + height / (2 * ROWS)

			var bC = blockContainer.instance()
			bC.set_position(Vector2(x, y))
			$Background/Stage.add_child(bC)
			matrix[row].append(bC)


func fetch_new_tetrominos():
	var palette_pos = $Background/Palette.rect_position
	var palette_rect_size = $Background/Palette.rect_size
	assert(len(available_tetrominos) == 0, "Palette must be empty before fetching new tetrominos")

	available_tetrominos.append(new_tetromino(Vector2(palette_pos.x + palette_rect_size.x / 2, palette_pos.y - 64 - palette_rect_size.y / 2), Vector2(palette_pos.x + palette_rect_size.x / 2, palette_pos.y + 1 * (palette_rect_size.y / 4))))
	available_tetrominos.append(new_tetromino(Vector2(palette_pos.x + palette_rect_size.x / 2, palette_pos.y - 64), Vector2(palette_pos.x + palette_rect_size.x / 2, palette_pos.y + 3 * (palette_rect_size.y / 4))))

	$Background/TetrominosPreparing.add_child(available_tetrominos[0])
	$Background/TetrominosPreparing.add_child(available_tetrominos[1])


func new_tetromino(initial_position, palette_position):
	var random_tetromino = randi() % 5
	var tetromino

	match random_tetromino:
		0:
			tetromino = tetromino_l.instance()
		1:
			tetromino = tetromino_line.instance()
		2:
			tetromino = tetromino_s.instance()
		3:
			tetromino = tetromino_square.instance()
		4:
			tetromino = tetromino_t.instance()

	#tetromino.rotation_index = randi() % 4
	tetromino.rotation_index = 1 #DEBUG: Dejar como estaba arriba ↑
	tetromino.set_rotation_degrees((tetromino.rotation_index) * 90)
	tetromino.set_position(initial_position)
	tetromino.set_palette_position(palette_position)
	tetromino.set_game(self)
	return tetromino


func get_closest_block_container(tetromino):
	var bounding_box_corner_center = tetromino.get_bounding_box_corner_block()
	print("Centro del bloque que estaría en la esquina superior izquierda del rectángulo que contiene al Tetromino:" + str(bounding_box_corner_center) + "; rotation_indx → " + str(tetromino.rotation_index))
	for row in range(ROWS):
		for col in range(COLS):
			if (matrix[row][col].get_corner_position() - bounding_box_corner_center) <= Vector2(16, 16):
				pass
