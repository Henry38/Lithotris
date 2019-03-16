extends TileMap

var FallingObject = preload("res://scripts/FallingObject.gd")

# Main variables
var current_block = null

var shapes = [
	preload("res://scenes/shapes/SquareShape.tscn"),
	preload("res://scenes/shapes/BarShape.tscn"),
	preload("res://scenes/shapes/LShape.tscn"),
	preload("res://scenes/shapes/SquiglyShape.tscn"),
	preload("res://scenes/shapes/TShape.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set Timer connexion
	randomize()
	$timer.connect("timeout", self, "trigger")

func _process(delta):
	if Input.is_action_just_pressed("rotate_left"):
		rotate_block(current_block, "left")
	elif Input.is_action_just_pressed("rotate_right"):
		rotate_block(current_block, "right")
	
	if Input.is_action_just_pressed("move_left"):
		update_block(current_block, Vector2(-1, 0))
	elif Input.is_action_just_pressed("move_right"):
		update_block(current_block, Vector2(1, 0))
		
	if Input.is_action_just_pressed("move_down"):
		move_block_down(current_block)


func trigger():
	move_block_down(current_block)

func move_block_down(block):
	if current_block == null:
		createNewBlock()
	
	clearBlock(current_block)
	move_block(current_block, Vector2(0, 1) )
	if checkCollisionBlock(current_block):
		move_block(current_block, Vector2(0, -1))
		displayBlock(current_block)
		createNewBlock()
	displayBlock(current_block)

func createNewBlock():
	var rand_tilemap : TileMap = shapes[randi() % shapes.size()].instance()
	var new_block = FallingObject.new(1, rand_tilemap.get_used_cells())
	new_block.x = 10
	new_block.y = 10
	current_block = new_block

# Return true if the current block touch the ground else false
func checkCollisionBlock(block) -> bool:
	if block == null:
		return false
		
	var collision = false
	var keep = []
	var pos = block.cell_position()
	var w = block.width
	var h = block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = block.get_cell(x,y)
			var id_below = block.get_cell(x,y+1)
			var id_left = block.get_cell(x-1,y)
			var id_right = block.get_cell(x+1,y)

			if id != -1 and (id_below == -1 or id_left == -1 or id_right == -1):
				keep.append(Vector2(x,y))

	for c in keep:
		var x = pos.x + c.x
		var y = pos.y + c.y
		var id = self.get_cell(x,y)
		if id != -1:
			collision = true
			break

	return collision

func update_block(block, delta = Vector2()):
	clearBlock(block)
	move_block(block, delta)
	if checkCollisionBlock(block):
		move_block(block, -delta)
	displayBlock(block)

func move_block(block, delta = Vector2()):
	if block == null or (delta.x == 0 and delta.y == 0):
		return
	
	block.x += delta.x
	block.y += delta.y


func rotate_block(block, direction = "left"):
	if block == null:
		return
	
	clearBlock(block)
	if direction == "left":
		block.rotate_left()
		if checkCollisionBlock(block):
			block.rotate_right()
	elif direction == "right":
		block.rotate_right()
		if checkCollisionBlock(block):
			block.rotate_left()
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
