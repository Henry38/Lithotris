extends TileMap

signal generate_block
signal prepare_block

var FallingObject = preload("res://scripts/FallingObject.gd")
onready var g = $"/root/global"

# Main variables
var current_block = null
var next_block = null
var resin_blocks = []

var lithography_charge_count = 5
export(int) var width = 10
export(int) var height = 20
export(int) var level = 0

var stateMachine = preload("res://scripts/StateMachine.gd").new()
var pathFinder = preload("res://scripts/PathFinder.gd").new()
var lighteningTile = preload("res://scripts/LighteningTile.gd").new()
onready var startPoint = Vector2(0, height - 1)
onready var endPointList = [Vector2(width, height-2),
							Vector2(width, height-4),
							Vector2(width, height-6),
							Vector2(width, height-8),
							Vector2(width, height-12),
							Vector2(width, height-16)
						   ]

const shapes = [
	preload("res://scenes/shapes/SquareShape.tscn"),
	preload("res://scenes/shapes/BarShape.tscn"),
	preload("res://scenes/shapes/LShape.tscn"),
	preload("res://scenes/shapes/ReverseLShape.tscn"),
	preload("res://scenes/shapes/SquiglyShape.tscn"),
	preload("res://scenes/shapes/ReverseSquiglyShape.tscn"),
	preload("res://scenes/shapes/TShape.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	init_grid()
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

func _input(event):	
	if not $timer.paused and event.is_action_pressed("lithography_power_up"):
		if stateMachine.is_normal() and lithography_charge_count > 0:
			stateMachine.require_litho()

	if stateMachine.is_showing_litho():
		if event is InputEventKey and event.pressed and event.scancode == KEY_SHIFT:
			stateMachine.reset()
			removeResin()
			$timer.set_paused(false)
		elif event is InputEventMouseButton and event.pressed:
			var cx = int((event.position.x - 300) / (self.cell_size.x * self.scale.x))
			var cy = int(event.position.y / (self.cell_size.y * self.scale.y))

			for r in resin_blocks:
				if r == Vector2(cx,cy):
					var id = self.get_cell(cx,cy)
					if id == g.RESIN_CLICKED_TILE:
						self.set_cell(cx,cy,g.RESIN_TILE)
					if id == g.RESIN_TILE:
						self.set_cell(cx,cy,g.RESIN_CLICKED_TILE)

func init_grid():
	for y in range(height + 1):
		for x in range(width + 1):
			if y == 0 or x == 0 or x == width or y == height:
				self.set_cell(x, y, g.WALL_TILE)
			else:
				self.set_cell(x, y, g.BACKGROUND_TILE)

	self.set_cellv(startPoint, g.STARTING_TILE)
	self.set_cellv(endPointList[level], g.ENDING_TILE)

func init_variable_state():
	current_block = null
	next_block = null
	resin_blocks.clear()
	stateMachine.reset()
	lithography_charge_count = (level+1)
	
func nextLevel():
	if level == endPointList.size() - 1:
		print("All level finished !")
		$timer.set_paused(true)
		return
	level += 1
	init_grid()
	init_variable_state()


func next_process_step():
	if current_block == null and stateMachine.is_needing_litho():
		$timer.set_paused(true)
		lithography_charge_count -= 1
		displayResin()
		stateMachine.show_litho()
		return false
	if current_block == null:
		createNewBlock()
	return true

func trigger():
	if next_process_step():
		move_block_down(current_block)

func move_block_down(block):
	if not next_process_step():
		return
	
	clearBlock(current_block)
	move_block(current_block, Vector2(0, 1) )
	if checkCollisionBlock(current_block):
		move_block(current_block, Vector2(0, -1))
		displayBlock(current_block)
		lighteningTile.lightenBlock(self, current_block)
		if pathFinder.pathfind(self, startPoint, endPointList[level]):
			nextLevel()
			return
		if not stateMachine.is_needing_litho():
			createNewBlock()
		else:
			current_block = null
	displayBlock(current_block)

func createNewBlock():
	if next_block == null:
		next_block = generate_block()
	
	current_block = next_block
	next_block = generate_block()
	emit_signal("generate_block")
	emit_signal("prepare_block", next_block)
	
	if checkCollisionBlock(current_block):
		print("Game Over !")
		$timer.set_paused(true)

func generate_block():
	var threshold = 60 - (level * 4)
	
	var id = g.ISOLATOR_TILE
	if (randi() % 100) < threshold:
		id = g.CONDUCTOR_TILE
	
	var rand_tilemap : TileMap = shapes[randi() % shapes.size()].instance()
	var new_block = FallingObject.new(id, rand_tilemap.get_used_cells())
	if (randi() % 2) == 0:
		new_block.rotate_left()
	else:
		new_block.rotate_right()
	new_block.x = int(width / 2) - int(new_block.width / 2)
	new_block.y = 1
	return new_block

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

			if id > g.BACKGROUND_TILE and (id_below <= g.BACKGROUND_TILE or id_left <= g.BACKGROUND_TILE or id_right <= g.BACKGROUND_TILE):
				keep.append(Vector2(x,y))

	for c in keep:
		var x = pos.x + c.x
		var y = pos.y + c.y
		var id = self.get_cell(x,y)
		if id > g.BACKGROUND_TILE:
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
			if id > g.BACKGROUND_TILE:
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
			if id > g.BACKGROUND_TILE:
				self.set_cell(pos.x + x, pos.y + y, id)

func displayResin():
	resin_blocks.clear()
	for x in range(1,width):
		for y in range(1,height):
			var id = self.get_cell(x,y)
			if id > g.BACKGROUND_TILE:
				resin_blocks.append(Vector2(x,y-1))
				self.set_cell(x,y-1,g.RESIN_TILE)
				break

func removeResin():
	for p in resin_blocks:
		var id = self.get_cell(p.x,p.y)
		if id == g.RESIN_CLICKED_TILE:
			var id_below = self.get_cell(p.x,p.y+1)
			if id_below == g.ISOLATOR_TILE:
				self.set_cell(p.x,p.y+1,g.BACKGROUND_TILE)
		self.set_cell(p.x,p.y,g.BACKGROUND_TILE)
	resin_blocks.clear()