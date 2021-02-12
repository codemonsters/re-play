extends RigidBody

func _process(delta):
	if global_transform.origin.y <= -10:
		global_transform.origin.x = 0
		global_transform.origin.y = 1.25
		global_transform.origin.z = 0
		set_linear_velocity(Vector3())

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
