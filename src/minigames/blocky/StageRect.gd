extends ColorRect

var matrix = []
var line_color = Color(51.0 / 255.0, 255.0 / 255.0, 51.0 / 255.0)

func _ready():
	# initialize stage matrix
	for x in range(12):
		matrix.append([])
		for y in range(12):
			matrix[x].append(false)
	for x in range(5):
		matrix[0][x] = true 
	
	matrix[10][10] = true
	matrix[10][11] = true
	matrix[11][10] = true
	matrix[11][11] = true

func _draw():
	# draw horizontal matrix lines
	var width = self.get_size().x
	var height = self.get_size().y
	
	for y in range(11):
		draw_line(Vector2(0, (y + 1) * height / 12), 
			Vector2(width - 1, (y + 1) * height / 12), 
			line_color, 1, true)
		
	# draw horizontal matrix lines
	for x in range(11):
		draw_line(Vector2((x + 1) * width / 12, 0), 
			Vector2((x + 1) * width / 12, height - 1), 
			line_color, 1, true)

