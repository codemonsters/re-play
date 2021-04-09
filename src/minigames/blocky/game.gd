extends Node2D

onready var tetromino_l = preload("res://minigames/blocky/tetrominos/tetromino_l.tscn")
onready var tetromino_line = preload("res://minigames/blocky/tetrominos/tetromino_line.tscn")
onready var tetromino_s = preload("res://minigames/blocky/tetrominos/tetromino_s.tscn")
onready var tetromino_square = preload("res://minigames/blocky/tetrominos/tetromino_square.tscn")
onready var tetromino_t = preload("res://minigames/blocky/tetrominos/tetromino_t.tscn")

func _ready():
	$Background/Palette.add_child(new_tetromino(Vector2(112, -64), Vector2(112, ($Background/Palette.rect_size.y / 4) * 3))) # TODO: Expresar posiciones origen y destino en función del tamaño del nodo Palette
	$Background/Palette.add_child(new_tetromino(Vector2(112, -192), Vector2(112, $Background/Palette.rect_size.y / 4))) # TODO: Expresar posiciones origen y destino en función del tamaño del nodo Palette


func new_tetromino(sourcePosition, destinationPosition):
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
	
	tetromino.set_rotation_degrees((randi() % 4) * 90)
	tetromino.set_position(sourcePosition)
	
	tetromino.sourcePosition = sourcePosition
	tetromino.destinationPosition = destinationPosition
	
	return tetromino
