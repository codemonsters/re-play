extends Node2D

var sourcePosition
var destinationPosition
var dragging = false # flag set to true while dragging the tetromino
var mouse_inside = false # flag, values is true when the mouse is inside BoundingBox

func _process(delta):
	# TODO: Inmplementar drag and drop cuando el jugador hace clic y mouse_inside es true
	if Input.is_action_just_released("click"):
		dragging = false
		print("NOT DRAGGING")
	elif Input.is_action_pressed("click") and mouse_inside:
		dragging = true
		print("DRAGGING")

	var shift_vector = (destinationPosition - position).normalized() * delta * 800
	if shift_vector.length() > (destinationPosition - position).length():
		position = destinationPosition
	else:
		position += shift_vector


func _physics_process(_dt):
	# If dragging is enabled, use mouse position to calculate movement
	if dragging:
		position = get_global_mouse_position()


func _on_BoundingBox_mouse_entered():
	mouse_inside = true
	

func _on_BoundingBox_mouse_exited():
	mouse_inside = false
