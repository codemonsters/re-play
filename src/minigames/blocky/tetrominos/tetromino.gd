extends Area2D

export var speed = 1000

var dragging = false # flag set to true while dragging the tetromino
var mouse_inside = false # flag, values is true when the mouse is inside BoundingBox
var initial_mouse_posisition
var palette_position
var available = false # flag, true if the tetromino is ready to be dragged
var pointer_offset = Vector2(0, 0) # distance between the pointer and the center of the tetromino
var game # Reference to main game object

func _process(delta):
	# Pieza vuelve a la paleta tras soltarla
	if palette_position and not dragging:
		var shift_vector = (palette_position - position).normalized() * delta * speed
		if shift_vector.length() > (palette_position - position).length():
			position = palette_position
		else:
			position += shift_vector
		
		if not available and position == palette_position:
			switch_parent("../../TetrominosAvailable")
			available = true
		else:
			available = false

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
		if mouse_inside and not available:
			var closest_anchor_point = game.get_closest_block_container(self)
	
	# Movemos pieza mientras arrastramos
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - pointer_offset


func _on_BoundingBox_gui_input(event):
	# Cogemos el tetromino (comenzamos a arrastrar)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and mouse_inside:
		pointer_offset = get_global_mouse_position() - position
		dragging = true


func set_palette_position(pos):
	assert(pos != null)
	palette_position = pos

func set_game(g):
	game = g
