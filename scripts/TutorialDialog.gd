extends Node2D

onready var dialog = $VBoxContainer

func _ready():
	#hide()
	pass
	
	
func _draw():
	var topX = dialog.rect_position.x
	var topY = dialog.rect_position.y
	var leftX = dialog.get_end().x
	var bottomY = dialog.get_end().y
	draw_rect(Rect2(topX, topY, leftX, bottomY), Color.white, true)
	draw_line(Vector2(topX - 5, topY), Vector2(leftX + 5, topY), Color.black, 2.0)
	draw_line(Vector2(topX - 5, bottomY), Vector2(leftX + 5, bottomY), Color.black, 2.0)

func highlight(position: Vector2, size : Vector2, title : String, content : String) -> void:
	$ColorRect.material.set_shader_param("position", position)
	$ColorRect.material.set_shader_param("size", size)
	# Set the text and stuff
	show()
