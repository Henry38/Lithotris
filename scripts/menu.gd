extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_screen = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$LeaveButton.connect("pressed", get_tree(), "quit")
	$LeadButton.connect("pressed", self, "changescenelead")
	$CreditsButton.connect("pressed", self, "changescenecredits")
	
func changescenelead():
	Transition.fade_to("res://scenes/Leaderboard.tscn")
	
func changescenecredits():
	Transition.fade_to("res://scenes/credits.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass