extends TileMap

var FallingObject = preload("res://scripts/FallingObject.gd")

# Main variables
var create_new_block = true
var current_block = null
var blocks = []

var pos = [Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(2,0)]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set Timer connexion
	$timer.connect("timeout", self, "trigger")

func trigger():
	# Creer nouvelle piece ?
	if create_new_block:
		create_new_block = false
		createNewBlock()

	# Si la  piece doit s'arreter
	elif checkCollisionBlock():
		create_new_block = true
		current_block = null

	# Sinon dscendre la piece	
	else:
		clearBlock()
		moveBlock()

	displayBlock()

func createNewBlock():
	var new_block = FallingObject.new(1, pos)
	new_block.x = 10
	new_block.y = 10
	#var new_block = null #FallingObject.new()	# TODO + setter la position
	current_block = new_block
	blocks.append(new_block)

# Return true if the current block touch the ground else false
func checkCollisionBlock():
	if current_block == null:
		return
		
	var collision = false
	var keep = []
	var pos = current_block.cell_position()
	var w = current_block.width
	var h = current_block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = current_block.get_cell(x,y)
			var id_below = current_block.get_cell(x,y+1)

			if id != -1 and id_below == -1:
				keep.append(Vector2(x,y))

	for c in keep:
		var x = pos.x + c.x
		var y = pos.y + c.y + 1
		var id = self.get_cell(x,y)
		if id != -1:
			collision = true
			break

	return collision

func moveBlock():
	if current_block == null:
		return
		
	current_block.y += 1

func clearBlock():
	if current_block == null:
		return

	var pos = current_block.cell_position()
	var w = current_block.width
	var h = current_block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = current_block.get_cell(x,y)
			if id != -1:
				self.set_cell(pos.x + x, pos.y + y, -1)

func displayBlock():
	if current_block == null:
		return

	var pos = current_block.cell_position()
	var w = current_block.width
	var h = current_block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = current_block.get_cell(x,y)
			if id != -1:
				self.set_cell(pos.x + x, pos.y + y, id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
