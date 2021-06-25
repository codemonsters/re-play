extends Spatial

func _ready():
	# Clear the viewport.
	var viewport = $Viewport
	$Viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)

	# Let two frames pass to make sure the vieport is captured.
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	# Retrieve the texture and set it to the viewport quad.
	$ViewportQuad.material_override.albedo_texture = viewport.get_texture()
