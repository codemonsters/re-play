extends Camera

var follow

func _ready():
	follow = get_parent().get_node("KinematicBody")

func _process(delta):
	var vector = Vector3()
	vector.z = cos(follow.alpha) * 5
	vector.y = sin(follow.alpha) * 5
#	global_transform.origin.x = follow.global_transform.origin.x
#	global_transform.origin.y = follow.global_transform.origin.y
#	global_transform.origin.z = follow.global_transform.origin.z
