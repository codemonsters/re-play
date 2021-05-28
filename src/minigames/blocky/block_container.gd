extends Area2D

func get_corner_position():
	return $CollisionShape2D/TextureRect.rect_position - Vector2($CollisionShape2D/TextureRect.rect_size / 2) + to_global(position)

