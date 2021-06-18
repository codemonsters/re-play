extends Area2D

export var speed = 1000

var dragging = false # flag set to true while dragging the tetromino
var mouse_inside = false # flag, values is true when the mouse is inside BoundingBox
var initial_mouse_posisition
var palette_position
var available = false # flag, true if the tetromino is ready to be dragged
var pointer_offset = Vector2(0, 0) # distance between the pointer and the center of the tetromino
var game # Reference to main game object
var rotation_index # 0 → no rotation; 1 → 90º; 2 → 180º; 3 → 270º

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
	if event is InputEventMouseButton and not event.pressed and \
			event.button_index == BUTTON_LEFT and not event.is_echo() and dragging:
		dragging = false
		var _closest_anchor_point = game.get_closest_block_container(self)
	# Movemos pieza mientras arrastramos
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - pointer_offset


func _on_BoundingBox_gui_input(event):
	# Cogemos el tetromino (comenzamos a arrastrar)
	if event is InputEventMouseButton and event.pressed and \
			event.button_index == BUTTON_LEFT and not event.is_echo():
		pointer_offset = get_global_mouse_position() - position
		dragging = true


func set_palette_position(pos):
	assert(pos != null)
	palette_position = pos

func set_game(g):
	game = g

func get_bounding_box_corner_block():
	var corner_block_pos = get_node("CollisionShape2D/BoundingBox").rect_position
	print(str(corner_block_pos) + "------- rect_pos")

	if rotation_index == 0:
		corner_block_pos += Vector2(16, 16) #DEBUG: Parece que funciona
	elif rotation_index == 1:
		corner_block_pos = Vector2((get_node("CollisionShape2D/BoundingBox").rect_size.x / 2), -16)
	elif rotation_index == 2:
		print(Vector2(get_node("CollisionShape2D/BoundingBox").rect_size.y - 16, 16))
		corner_block_pos -= Vector2(get_node("CollisionShape2D/BoundingBox").rect_size.y - 16, 16) #TODO: NO funciona, da datos erróneos :s
	else:
		corner_block_pos += Vector2(16, 16 - get_node("CollisionShape2D/BoundingBox").rect_size.x)
	return corner_block_pos
