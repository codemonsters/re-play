extends Node2D

signal blocky_start_game


func _on_StartBlinkTimer_timeout():
	get_node("Start").visible = !get_node("Start").visible


func _input(event):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		emit_signal("blocky_start_game")
