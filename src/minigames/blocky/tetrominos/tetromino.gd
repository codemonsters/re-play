extends Node2D

var sourcePosition
var destinationPosition


func _ready():
	connect("input_event", self, "_on_input_event")


func _input(event):
	#print("event")
	pass

func get_size():
	var x_max = 0
	var x_min = 0
	var y_max = 0
	var y_min = 0
	
	for child in get_children():
		if child.position.x < x_min:
			x_min = child.position.x
		if child.position.x > x_max:
			x_max = child.position.x
		if child.position.y < y_min:
			y_min = child.position.y
		if child.position.y > y_max:
			y_max = child.position.y
	
	var width = (x_max - x_min) - $Block1.get_size().x
	var height = (y_max - y_min) - $Block1.get_size().y
	
	return Vector2(width, height)
	

func _process(delta):
	var shift_vector = (destinationPosition - position).normalized() * delta * 800
	if shift_vector.length() > (destinationPosition - position).length():
		position = destinationPosition
	else:
		position += shift_vector


func _on_input_event():
	print("TOCADO: ")


func _on_Tetromino_input_event(viewport, event, shape_idx):
	print("tocado2")
