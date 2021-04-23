extends Node2D

var sourcePosition
var destinationPosition
var dragging = false # flag set to true while dragging the tetromino


func _process(delta):
	var shift_vector = (destinationPosition - position).normalized() * delta * 800
	if shift_vector.length() > (destinationPosition - position).length():
		position = destinationPosition
	else:
		position += shift_vector


func _physics_process(_dt):
	# If dragging is enabled, use mouse position to calculate movement
	if dragging:
		position = get_global_mouse_position()


func _on_ColorRect_mouse_entered():
	print("AHHHHHHHHHHHH") 
