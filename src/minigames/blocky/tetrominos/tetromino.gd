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
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		dragging = false
		print(get_parent().name)
		if get_parent().name != "Palette":
			print(get_parent().name)
			var new_parent = get_node("/../Background/Palette/")
			get_parent().remove_child(self)
			new_parent.add_child(self)


func _on_BoundingBox_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and mouse_inside:
			dragging = true
			print(dragging)
			if dragging:
				var new_parent = get_node("../../../ActiveTetromino")
				get_parent().remove_child(self)
				new_parent.add_child(self)
	elif event is InputEventMouseMotion and dragging:
		position = get_local_mouse_position()
