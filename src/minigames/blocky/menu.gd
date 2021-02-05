extends Node2D


func _on_StartBlinkTimer_timeout():
	get_node("Start").visible = !get_node("Start").visible

