extends Node2D

onready var dialog = $VBoxContainer

func _ready():
	#hide()
	pass

func update_rect(position: Vector2, size: Vector2):
	$ColorRect.material.set_shader_param("position", position)
	$ColorRect.material.set_shader_param("size", size)

func highlight(position: Vector2, size : Vector2, title : String, content : String) -> void:
	$ColorRect.material.set_shader_param("position", position)
	$ColorRect.material.set_shader_param("size", size)
	# Set the text and stuff
	$VBoxContainer/Title.set_text(title)
	$VBoxContainer/Content.set_text(content)
	show()
