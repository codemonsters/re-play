extends StaticBody

var mass = 0
var time = 0
var angularVelocity = Vector2()
var linearVelocity = Vector2()
var angulo = 0
var x
var y
var z
var xc
var yc

func _ready():
	x = 0
	y = get_parent().get_node("Agarre").global_transform.origin.y - 3
	z = get_parent().get_node("Agarre").global_transform.origin.z
	xc = get_parent().get_node("Agarre").global_transform.origin.x
	yc = get_parent().get_node("Agarre").global_transform.origin.y

func _process(delta):
	time += delta
	#angularVelocity = Vector2(sin(time) * 5, sin(time) * 5)
	#angulo = sin(time) * 10 #angularVelocity.length()
	#linearVelocity = Vector2(cos(angulo), sin(angulo))
	#print(angulo)
	#translate(Vector3(linearVelocity.x, linearVelocity.y, 0))
	# posicionAngular = amplitud * sen(velocidadAngular * 180)
	
	# (x - x_centro)^2 + (y - y_centro)^2 = radio^2
	# y = raiz(radio^2 - x^2)
	x += delta
	var a = sqrt(9 - pow(x - xc, 2))
	y = a + yc
	self.global_transform.origin = Vector3(x, y, z)
