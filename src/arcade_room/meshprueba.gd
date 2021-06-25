tool
extends MeshInstance

export (int) var ancho = 1 setget set_ancho
export (int) var alto = 1 setget set_alto
export (int) var largo = 1 setget set_largo
var size = Vector3(ancho, alto, largo)

#func set_mesh(value):
	# value = string; "amarillo"
	# get_modelo(value) -> "camino/al/modelo.obj"
	# mesh = newMeshInstance("camino/al/modelo")

func set_ancho(value):
	ancho = value
	update()

func set_alto(value):
	alto = value
	update()

func set_largo(value):
	largo = value
	update()

func update():
	size = Vector3(ancho, alto, largo)
	mesh.size = size

#func _get(property):
#	if property == "ancho":
#		return ancho
#	if property == "alto":
#		return alto
#	if property == "largo":
#		return largo
#
#func _set(property, value):
#	print("aADADAD")
#	if property == "ancho":
#		ancho = value
#		return true
#	if property == "alto":
#		alto = value
#		return true
#	if property == "largo":
#		largo = value
#		return true
#	size = Vector3(ancho, alto, largo)
#
#func _get_property_list():
#	return [
#		{
#			"hint": PROPERTY_HINT_NONE,
#			"usage": PROPERTY_USAGE_DEFAULT,
#			"name": "ancho",
#			"type": TYPE_INT
#		},
#		{
#			"hint": PROPERTY_HINT_NONE,
#			"usage": PROPERTY_USAGE_DEFAULT,
#			"name": "alto",
#			"type": TYPE_INT
#		},
#		{
#			"hint": PROPERTY_HINT_NONE,
#			"usage": PROPERTY_USAGE_DEFAULT,
#			"name": "largo",
#			"type": TYPE_INT
#		}
#	]
