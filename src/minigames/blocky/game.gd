extends Node2D

onready var tetromino_l = preload("res://minigames/blocky/tetrominos/tetromino_l.tscn")
onready var tetromino_line = preload("res://minigames/blocky/tetrominos/tetromino_line.tscn")
onready var tetromino_s = preload("res://minigames/blocky/tetrominos/tetromino_s.tscn")
onready var tetromino_square = preload("res://minigames/blocky/tetrominos/tetromino_square.tscn")
onready var tetromino_t = preload("res://minigames/blocky/tetrominos/tetromino_t.tscn")

func _ready():
	var tetromino = new_tetromino()
	$Background/Palette.add_child(tetromino)

func new_tetromino():
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
	
	
	tetromino.set_position(Vector2($Background/Palette.get_size().x / 2, tetromino.get_size().y / 2))
	tetromino.set_rotation_degrees((randi() % 4) * 90)
	return tetromino
