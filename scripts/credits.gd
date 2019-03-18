extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lead_bdd =  "Wait"
var lead = []
onready var anima = get_node("RichTextLabel/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	$BackButton.connect("pressed", self, "backba")
	anima.play("anim")
	$RichTextLabel/AudioStreamPlayer.play()
	
func backba():
	Transition.fade_to("res://scenes/Menu.tscn")

