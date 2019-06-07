extends CanvasLayer

signal tutorial_finished

onready var parts = [
	{
		"title": "",
		"text": "",
		"widget": $Grid
	},
	{
		"title" : "",
		"text" : "",
		"widget" : $ScoreLabel
	},
	{
		"title" : "",
		"text" : "",
		"widget" : $Incomings	
	},
	{
		"title" : "",
		"text" : "",
		"widget": $Lithographies
	},
	{
		"title" : "",
		"text" : "",
		"widget": $VBoxContainer
	}
]

func _ready():
	for i in parts:
		print(i)
		i["widget"].visible = false
	$Grid/TileMap.stateMachine.show_victory()
	
func show_next() -> void:
	if parts.empty(): 
		emit_signal("tutorial_finished")
		return
	var next = parts.pop_front()
	
	