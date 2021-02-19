extends CanvasLayer

func _ready():
	var _ignored = $Screen/Menu.connect("blocky_start_game", self, "on_start_game")

func on_start_game():
	print("Empecemos")
	var game_scene = preload("res://minigames/blocky/game.tscn")

	get_node("Screen/Menu").queue_free()
	var screen_node = get_parent().get_node("Blocky/Screen")
	screen_node.add_child(game_scene.instance())
