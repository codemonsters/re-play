extends StaticBody

var mass = 10
var time = 0
var collider = Node
var colliding = false
var x
var y
var z
var xc
var yc
var radio
var alpha
var direction

func _ready():
	alpha = 0
	radio = 3
	direction = -1
	z = get_parent().get_node("Agarre").global_transform.origin.z
	xc = get_parent().get_node("Agarre").global_transform.origin.x
	yc = get_parent().get_node("Agarre").global_transform.origin.y

func _process(delta):
	if alpha >= 180:
		direction = 1
	else:
		direction = -1
	x = xc + (radio * cos(deg2rad(alpha)))
	y = yc + ((radio * sin(deg2rad(alpha))) * direction)
	self.global_transform.origin.x = x
	self.global_transform.origin.y = y
	self.global_transform.origin.z = z
	
	set_constant_linear_velocity(Vector3(direction * 5, 0, 0))
	if colliding:
		collider.collisionVelocity = get_constant_linear_velocity() * (mass / collider.mass)

func _on_Timer_timeout():
	alpha += 1
	get_node("MeshInstance").rotate_object_local(Vector3(0, 0, 1), deg2rad(direction))
	get_node("CollisionShape").rotate_object_local(Vector3(0, 0, 1), deg2rad(direction))
	get_node("Area/CollisionShape").rotate_object_local(Vector3(0, 0, 1), deg2rad(direction))
	if alpha >= 360:
		alpha = 0

func _on_Area_body_entered(body):
	if body is KinematicBody:
		collider = body
		colliding = true

func _on_Area_body_exited(body):
	if body == collider:
		colliding = false
