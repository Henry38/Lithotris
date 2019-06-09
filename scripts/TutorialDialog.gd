extends Node2D



func _ready():
	hide()
	
func highlight(position: Vector2, size : Vector2, title : String, content : String) -> void:
	$ColorRect.material.set_shader_param("position", position)
	$ColorRect.material.set_shader_param("size", size)
	# Set the text and stuff
	show()
