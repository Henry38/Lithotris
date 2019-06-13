extends Node2D

var score = 0

func add_score(to_add : int):
	score += to_add
	display_score(score)
	
func display_score(score: int):
	$VBoxContainer/ScoreValue.text = str(score)

