extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lead_bdd =  "Wait"
#var lead = [["Florentin", 12], ["Azarias", 43], ["Henri", 32]]

const FILE_NAME = "user://leaders.json"
const LABEL = preload("res://scenes/material/GenericLabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var saveFile = File.new()
	if saveFile.file_exists(FILE_NAME):
		read_file(FILE_NAME)
	else:
		saveFile.open(FILE_NAME, File.WRITE)
		var arr = [102, 50, 300]
		show_leaders(arr)
		saveFile.store_string(to_json(arr))
		saveFile.close()
	$BackButton.connect("pressed", self, "backb")
	
func read_file(file):
	var f = File.new()
	f.open(FILE_NAME, File.READ)
	var arr = parse_json(f.get_as_text())
	f.close()
	print(arr)
	arr.sort()
	arr.invert()
	show_leaders(arr)
	
func show_leaders(ary):
	for l in ary:
		var score = LABEL.instance()
		score.text = "Anonyme : " + str(l)
		$VBoxContainer.add_child(score)
	
func backb():
	Transition.fade_to("res://scenes/Menu.tscn")
