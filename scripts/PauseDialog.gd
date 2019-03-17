extends WindowDialog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/ResumeButton.connect("pressed", self, "hide")
	$VBoxContainer/MenuButton.connect("pressed", self, "goto_menu")
	$VBoxContainer/RestartButton.connect("pressed", self, "restart")

func restart():
	self.hide()
	Transition.fade_to("res://scenes/Gameplay.tscn")

func goto_menu():
	self.hide()
	Transition.fade_to("res://scenes/Menu.tscn")


