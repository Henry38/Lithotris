extends Node2D

signal next_clicked
signal skip_clicked

onready var dialog = $VBoxContainer

func _ready():
	#hide()
	pass

func emit(val : String) -> void:
	emit_signal(val)

func update_rect(position: Vector2, size: Vector2):
	$ColorRect.material.set_shader_param("position", position)
	$ColorRect.material.set_shader_param("size", size)

func set_infos(title : String, content : String) -> void:
	$VBoxContainer/Title.set_text(title)
	$VBoxContainer/Content.set_text(content)
