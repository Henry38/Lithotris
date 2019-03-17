extends HBoxContainer

export (bool) var show_pause_button = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if not show_pause_button:
		$PauseButton.hide()
		$SoundButton.connect("pressed", self, "set_mute_state")
		
func set_mute_state():
	var ismuted = $SoundButton.pressed
	for i in range (AudioServer.get_bus_count()):
		AudioServer.set_bus_mute(i, ismuted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
