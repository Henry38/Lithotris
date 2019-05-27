extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$BackButton.connect("pressed", self, "backba")
	
func backba():
	Transition.fade_to("res://scenes/Menu.tscn")

