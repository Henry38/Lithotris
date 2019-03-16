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

func _process(delta):
	if Input.is_action_just_pressed("rotate_left"):
		rotate_block(current_block, "left")
	elif Input.is_action_just_pressed("rotate_right"):
		rotate_block(current_block, "right")
	
	if Input.is_action_just_pressed("move_left"):
		move_block(current_block, -1)
	elif Input.is_action_just_pressed("move_right"):
		move_block(current_block, 1)

func trigger():
	# Creer nouvelle piece ?
	if create_new_block:
		create_new_block = false
		createNewBlock()

	# Si la  piece doit s'arreter
	elif checkCollisionBlock(current_block):
		create_new_block = true
		current_block = null

	# Sinon dscendre la piece	
	else:
		clearBlock(current_block)
		moveBlock(current_block)

	displayBlock(current_block)

func createNewBlock():
	var new_block = FallingObject.new(1, pos)
	new_block.x = 10
	new_block.y = 10
	current_block = new_block
	blocks.append(new_block)

# Return true if the current block touch the ground else false
func checkCollisionBlock(block):
	if block == null:
		return
		
	var collision = false
	var keep = []
	var pos = block.cell_position()
	var w = block.width
	var h = block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = block.get_cell(x,y)
			var id_below = block.get_cell(x,y+1)

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

func move_block(block, xDelta = 0):
	if block == null or xDelta == 0:
		return
	
	clearBlock(block)
	block.x += xDelta
	displayBlock(block)

func rotate_block(block, direction = "left"):
	if block == null:
		return
	
	clearBlock(block)
	if direction == "left":
		block.rotate_left()
	elif direction == "right":
		block.rotate_right()
	displayBlock(block)

func moveBlock(block):
	if block == null:
		return
		
	block.y += 1

func clearBlock(block):
	if block == null:
		return

	var pos = block.cell_position()
	var w = block.width
	var h = block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = block.get_cell(x,y)
			if id != -1:
				self.set_cell(pos.x + x, pos.y + y, -1)

func displayBlock(block):
	if block == null:
		return

	var pos = block.cell_position()
	var w = block.width
	var h = block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = block.get_cell(x,y)
			if id != -1:
				self.set_cell(pos.x + x, pos.y + y, id)
