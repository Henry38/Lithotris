extends CanvasLayer

export (int) var block_penality = 10

onready var tilemap = $Grid/TileMap
onready var progress = $VBoxContainer/Progress

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap.connect("generate_block", progress, "progress", [block_penality])
	progress.connect("max_reached", self, "_max_ecological_impact")
	
func _max_ecological_impact():
	print("Ecological impact to high")
