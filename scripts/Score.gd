extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func add_score(to_add : int):
	score += to_add
	display_score(score)
	
func display_score(score: int):
	$ScoreValue.text = str(score)

