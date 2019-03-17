extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lead_bdd =  "Wait"
var lead = [["Florentin", 12], ["Azarias", 43], ["Henri", 32]]

# Called when the node enters the scene tree for the first time.
func _ready():
	$BackButton.connect("pressed", self, "backb")
	
func backb():
	get_tree().change_scene("res://scenes/Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
