extends Camera

var follow

func _ready():
	follow = get_parent().get_node("Jugador").get_node("KinematicBody")

func _process(delta):
	self.global_transform.origin.x = follow.global_transform.origin.x
	self.global_transform.origin.y = follow.global_transform.origin.y + 2.5
	self.global_transform.origin.z = follow.global_transform.origin.z + 5
