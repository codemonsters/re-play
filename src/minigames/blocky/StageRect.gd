extends ColorRect

const ROWS = 12
const COLS = 12

var matrix = []
var line_color = Color(51.0 / 255.0, 255.0 / 255.0, 51.0 / 255.0)

func _ready():
	# initialize stage matrix
	for x in range(ROWS):
		matrix.append([])
		for y in range(COLS):
			matrix[x].append(false)
	for x in range(5):
		matrix[0][x] = true 
	
	#matrix[10][10] = true
	#matrix[10][11] = true
	#matrix[11][10] = true
	#matrix[11][11] = true
	var blockContainer = preload("res://minigames/blocky/block_container.tscn")
	
	var width = get_size().x
	var height = get_size().y
	
	for row in range(ROWS):
		for col in range(COLS):
			var x = col * width / COLS + width / (2 * COLS)
			var y = row * height / ROWS + height / (2 * ROWS)
			var bC = blockContainer.instance()
			bC.set_position(Vector2(x, y))
			add_child(bC)
	

func _draw():
	# draw horizontal matrix lines
	var width = self.get_size().x
	var height = self.get_size().y
	
	for y in range(11):
		draw_line(Vector2(0, (y + 1) * height / ROWS), 
			Vector2(width - 1, (y + 1) * height / ROWS), 
			line_color, 1, true)
		
	# draw horizontal matrix lines
	for x in range(11):
		draw_line(Vector2((x + 1) * width / COLS, 0), 
			Vector2((x + 1) * width / COLS, height - 1), 
			line_color, 1, true)
	
