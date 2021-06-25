extends StaticBody

var time = 0

func _process(delta):
	time += delta
	self.global_transform.origin.z = -5 + sin(time)
