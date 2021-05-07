extends Area2D


var palettePosition
var dragging = false # flag set to true while dragging the tetromino
var mouse_inside = false # flag, values is true when the mouse is inside BoundingBox
var initial_mouse_posisition

func _process(delta):
	# Pieza vuelve a la paleta tras soltarla
	if not dragging:
		var shift_vector = (to_global(palettePosition) - to_global(position)).normalized() * delta * 100
		if shift_vector.length() > (to_global(palettePosition) - to_global(position)).length():
			position = palettePosition
			if get_parent().name != "Palette":
				switch_parent("../../Background/Palette")
			else:
				print("en posición")
				position = to_global(position)
				switch_parent("../../../Background")
		else:
			position += shift_vector


func _on_BoundingBox_mouse_entered():
	mouse_inside = true


func _on_BoundingBox_mouse_exited():
	mouse_inside = false


func switch_parent(new_parent):
	# Podríamos no haberlo declarado como variable. Sin embargo, peta. NO CAMBIAR.
	var new_parent_node = get_node(new_parent)
	get_parent().remove_child(self)
	new_parent_node.add_child(self)


func _input(event):
	# Botón izquierdo liberado (soltamos los tetrominos)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		dragging = false
	# Movemos pieza mientras arrastramos
	elif event is InputEventMouseMotion and dragging:
		print("POSICIÓN LOCAL: " + str((position)) + "POSICIÓN GLOBAL: " + str(to_global(position)))
		position = get_global_mouse_position()


func _on_BoundingBox_gui_input(event):
	# Cogemos el tetromino (comenzamos a arrastrar)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and mouse_inside:
		position = get_global_mouse_position()
		dragging = true
		switch_parent("../../../ActiveTetromino")
