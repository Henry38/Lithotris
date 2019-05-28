extends Button



func _ready():
	connect("pressed", Transition, "fade_to", ["res://scenes/Menu.tscn"])