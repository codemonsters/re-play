extends RigidBody

func _integrate_forces(state):
	set_linear_velocity(Vector3(0, 0, 50))
