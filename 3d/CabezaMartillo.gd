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
var radio
var alpha
var velocity

func _ready():
	alpha = 0
	radio = 3
	velocity = 10
	z = get_parent().get_node("Agarre").global_transform.origin.z
	xc = get_parent().get_node("Agarre").global_transform.origin.x
	yc = get_parent().get_node("Agarre").global_transform.origin.y + radio

func _process(delta):
	print(alpha)
	x = xc + (radio * cos(deg2rad(alpha)))
	if alpha > 180:
		y = yc + (radio * sin(deg2rad(alpha)))
	else:
		y = yc - (radio * sin(deg2rad(alpha)))
	self.global_transform.origin.x = x
	self.global_transform.origin.y = y
	self.global_transform.origin.z = z


func _on_Timer_timeout():
	alpha += 1
	if alpha >= 360:
		alpha = 0
