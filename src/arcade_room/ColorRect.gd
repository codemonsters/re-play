extends ColorRect

var time = 0

func _process(delta):
	time += delta
	rect_position.y = (sin(time) * 100) + 100
