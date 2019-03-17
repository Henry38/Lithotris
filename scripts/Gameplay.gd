extends CanvasLayer

export (int) var block_penality = 10

onready var tilemap = $Grid/TileMap
onready var progress = $VBoxContainer/Progress
onready var incoming = $IncomingMap
onready var g = $"/root/global"

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap.connect("generate_block", progress, "progress", [block_penality])
	tilemap.connect("prepare_block", self, "_show_next_block")
	progress.connect("max_reached", self, "_max_ecological_impact")
	$Grid/TileMap.litho_provider = $Lithographies
	
func _max_ecological_impact():
	tilemap.show_game_over()
	print("Ecological impact to high")


func _show_next_block(block):
	for c in incoming.get_used_cells():
		incoming.set_cellv(c, -1)
	
	for y in range(block.height):
		for x in range(block.width):
			if not g.is_useless(block.matrix[x][y]):
				incoming.set_cell(x, y, block._cellId)