extends Camera

var follow

func _ready():
	follow = get_parent().get_node("KinematicBody")

func _process(delta):
	global_transform.origin.x = follow.global_transform.origin.x
	global_transform.origin.y = follow.global_transform.origin.y + 2.5 + sin(follow.alpha) * 5
	global_transform.origin.z = follow.global_transform.origin.z + cos(follow.alpha) * 5
