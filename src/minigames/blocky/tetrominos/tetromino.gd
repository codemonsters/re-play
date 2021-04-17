extends Node2D

var sourcePosition
var destinationPosition
var dragging = false # flag set to true while dragging the tetromino


func _ready():
	connect("input_event", self, "_on_input_event")

#func _enter_tree():
#	self.connect("input_event", self, "_on_input_event")
	
		
func _process(delta):
	var shift_vector = (destinationPosition - position).normalized() * delta * 800
	if shift_vector.length() > (destinationPosition - position).length():
		position = destinationPosition
	else:
		position += shift_vector



func _on_input_event(viewport, event, shape_idx):
	print("BOOM!!!!")
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			dragging = event.pressed


#func _input(event):
#	print("BANG!!!")
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and not event.pressed:
#			dragging = false


func _physics_process(dt):
	# If dragging is enabled, use mouse position to calculate movement
	if dragging:
		position = get_global_mouse_position()
