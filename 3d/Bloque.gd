extends StaticBody

var mass = 1000
var time = 0
var collider = Node
var colliding = false

func _process(delta):
	time += delta
	set_constant_linear_velocity(Vector3(sin(time) * 5, 0, 0))
	translate(get_constant_linear_velocity() * delta)
	if colliding:
		collider.collisionVelocity = get_constant_linear_velocity() * (mass / collider.mass)


func _on_Area_body_entered(body):
	if body is KinematicBody:
		collider = body
		colliding = true


func _on_Area_body_exited(body):
	if body == collider:
		colliding = false
