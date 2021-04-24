extends Area2D

var sourcePosition
var destinationPosition
var dragging = false # flag set to true while dragging the tetromino
var mouse_inside = false # flag, values is true when the mouse is inside BoundingBox
var initial_mouse_posisition

func _process(delta):
	if not dragging:
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


func _on_BoundingBox_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and mouse_inside:
		dragging = event.pressed
		#initial_mouse_position = event.position
	elif event is InputEventMouseMotion and dragging:
		#position = get_global_mouse_position()
		#set_position(get_viewport().get_mouse_position() + camera.global_position)
		#position = event.relative
		#position = get_viewport().get_mouse_position()
		#position = get_global_transform().origin + event.position
		#position = get_canvas_transform().affine_inverse().xform(event.position)
		#shift_vector = position - initial_mouse_position
		position = get_local_mouse_position()
