extends CanvasLayer

func _ready():
	$Screen/Menu.connect("blocky_start_game", self, "on_start_game")

func on_start_game():
	print("Empecemos")
	var game_scene = load("game.tscn")


	#get_node("Screen").remove_child(get_node("Menu"))
	#get_node("Screen").queue_free()
	get_parent().get_node("Blocky/Screen").add_child(game_scene)