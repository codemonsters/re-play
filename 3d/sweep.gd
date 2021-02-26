extends RigidBody

var time = 0

func _physics_process(delta):
	var velocity = self.get_linear_velocity()
	time += delta
	velocity.x = sin(time) * 5
	self.set_linear_velocity(velocity)
	self.set_angular_velocity(Vector3(0, 0, 0))
	#self.look_at(Vector3(0, 0, 1), Vector3.UP)
