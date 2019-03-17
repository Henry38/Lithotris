extends HBoxContainer

export (bool) var show_pause_button = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if not show_pause_button:
		$PauseButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
