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
	get_tree().change_scene("res://scenes/Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
