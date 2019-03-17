extends Control


onready var screens = [
	$ecran1,
	$ecran2,
	$ecran3
]

var current_screen = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for s in screens:
		s.hide()
	show_screen()
	$SkipButton.connect("pressed", self, "play")
	$NextButton.connect("pressed", self, "next_screen")
	

func show_screen():
	screens[current_screen].show()
	
func next_screen():
	if current_screen == screens.size() - 1: 
		play()
		return
	
	screens[current_screen].hide()
	current_screen += 1
	if current_screen < screens.size():
		screens[current_screen].show()
	
	if current_screen == screens.size() - 1:
		final_screen()
		
func final_screen():
	$NextButton.text = "Jouer"
	$SkipButton.hide()
	
func play():
	Transition.fade_to("res://scenes/Gameplay.tscn")