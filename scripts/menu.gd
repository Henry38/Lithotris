extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_screen = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$LeaveButton.connect("pressed", get_tree(), "quit")
	$LeadButton.connect("pressed", self, "goto_scene", ["res://scenes/Leaderboard.tscn"])
	$CreditsButton.connect("pressed", self, "goto_scene", ["res://scenes/credits.tscn"])
	$PlayButton.connect("pressed", self, "goto_scene", ["res://scenes/Tutorial.tscn"])

func goto_scene(scene: String):
	Transition.fade_to(scene)