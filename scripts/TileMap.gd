extends TileMap

var FallingObject = preload("res://scripts/FallingObject.gd")

# Main variables
var current_block = null
var resin_blocks = []
var preload_lithopgraphy_power_up = false
var display_lithopgraphy_power_up = false
var picking_resin_state_on = false
export(int) var width = 10
export(int) var height = 20

var pathFinder = preload("res://scripts/PathFinder.gd").new()
onready var startPoint = Vector2(width, 10)
onready var endPoint = Vector2(0, height - 1)

const WALL_TILE = 5
const BACKGROUND_TILE = 0

const shapes = [
	preload("res://scenes/shapes/SquareShape.tscn"),
	preload("res://scenes/shapes/BarShape.tscn"),
	preload("res://scenes/shapes/LShape.tscn"),
	preload("res://scenes/shapes/SquiglyShape.tscn"),
	preload("res://scenes/shapes/TShape.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():	
	randomize()
	init_grid()
	self.set_cellv(startPoint, 3)
	self.set_cellv(endPoint, 4)
	$timer.connect("timeout", self, "trigger")

func _process(delta):
	if not $timer.paused:
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
	
	if display_lithopgraphy_power_up:
		displayResin()
		display_lithopgraphy_power_up = false
		picking_resin_state_on = true

func _input(event):	
	if event.is_action_pressed("debug"):
		print(pathFinder.pathfind(self, startPoint, endPoint))

	if not $timer.paused and event.is_action_pressed("lithography_power_up"):
		if not preload_lithopgraphy_power_up:
			preload_lithopgraphy_power_up = true

	if picking_resin_state_on:
		if event is InputEventKey and event.pressed and event.scancode == KEY_SHIFT:
			picking_resin_state_on = false
			removeResin()
			$timer.set_paused(false)
		elif event is InputEventMouseButton and event.pressed:
			var cx = int(event.position.x / (self.cell_size.x * self.scale.x))
			var cy = int(event.position.y / (self.cell_size.y * self.scale.y))

			for r in resin_blocks:
				if r == Vector2(cx,cy):
					var id = self.get_cell(cx,cy)
					if id == 7:
						self.set_cell(cx,cy,6)
					if id == 6:
						self.set_cell(cx,cy,7)

func init_grid():
	for y in range(height + 1):
		for x in range(width + 1):
			if y == 0 or x == 0 or x == width or y == height:
				self.set_cell(x, y, WALL_TILE)
			else:
				self.set_cell(x, y, BACKGROUND_TILE)
		

func trigger():
	if current_block == null and preload_lithopgraphy_power_up:
		$timer.set_paused(true)
		preload_lithopgraphy_power_up = false
		display_lithopgraphy_power_up = true
		return

	move_block_down(current_block)

func move_block_down(block):
	if current_block == null:
		createNewBlock()
	
	clearBlock(current_block)
	move_block(current_block, Vector2(0, 1) )
	if checkCollisionBlock(current_block):
		move_block(current_block, Vector2(0, -1))
		displayBlock(current_block)
		if pathFinder.pathfind(self, startPoint, endPoint):
			print("Finished")
			return
		if not preload_lithopgraphy_power_up:
			createNewBlock()
		else:
			current_block = null
	displayBlock(current_block)

func createNewBlock():
	var rand_tilemap : TileMap = shapes[randi() % shapes.size()].instance()
	var new_block = FallingObject.new(1 + (randi() % 2), rand_tilemap.get_used_cells())
	new_block.x = int(width / 2) - int(new_block.width / 2)
	new_block.y = 1
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

			if id > 0 and (id_below <= 0 or id_left <= 0 or id_right <= 0):
				keep.append(Vector2(x,y))

	for c in keep:
		var x = pos.x + c.x
		var y = pos.y + c.y
		var id = self.get_cell(x,y)
		if id > 0:
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
			if id > 0:
				self.set_cell(pos.x + x, pos.y + y, 0)

func displayBlock(block):
	if block == null:
		return

	var pos = block.cell_position()
	var w = block.width
	var h = block.height

	for y in range(0,h):
		for x in range(0,w):
			var id = block.get_cell(x,y)
			if id > 0:
				self.set_cell(pos.x + x, pos.y + y, id)

func displayResin():
	resin_blocks.clear()
	for x in range(1,width):
		for y in range(1,height):
			var id = self.get_cell(x,y)
			if id > 0:
				resin_blocks.append(Vector2(x,y-1))
				self.set_cell(x,y-1,6)
				break

func removeResin():
	for p in resin_blocks:
		var id = self.get_cell(p.x,p.y)
		if id == 7:
			var id_below = self.get_cell(p.x,p.y+1)
			if id_below == 2:
				self.set_cell(p.x,p.y+1,0)
		self.set_cell(p.x,p.y,0)