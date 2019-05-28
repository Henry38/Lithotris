extends WindowDialog

func _ready():
	pass

func restart():
	self.hide()
	Transition.fade_to("res://scenes/Gameplay.tscn")

func goto_menu():
	self.hide()
	Transition.fade_to("res://scenes/Menu.tscn")
	MusicMenu.get_node("Music").play()


