extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_cell(10, 10, 1)
	var c = self.get_cell(6, 6)
	print(c)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
