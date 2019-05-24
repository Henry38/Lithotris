extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/LeaveButton.connect("pressed", get_tree(), "quit")
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/LeadButton.connect("pressed", self, "goto_scene", ["res://scenes/Leaderboard.tscn"])
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/CreditsButton.connect("pressed", self, "goto_scene", ["res://scenes/credits.tscn"])
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/HBoxContainer/PlayButton.connect("pressed", self, "play")

func play():
	MusicMenu.get_node("Music").stop()
	Transition.fade_to("res://scenes/Tutorial.tscn")