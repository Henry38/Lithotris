extends Node2D

onready var container = $SpriteContainer

export (int) var start_lithographies = 5
export (Texture) var litho_symbol = null

func use_litho():
	var c_count = container.get_child_count()
	if c_count == 0:
		return false
		
	container.remove_child(container.get_child(c_count-1))
	return true

func has_litho():
	return container.get_child_count() > 0

func _ready():
	if litho_symbol == null:
		return
	
	for i in range(start_lithographies):
		var s = Sprite.new()
		s.position.x = (i* (litho_symbol.get_size().x + 5))
		s.texture = litho_symbol
		print("add sprite")
		container.add_child(s)


