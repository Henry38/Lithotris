extends Node


func quit() -> void:
	get_tree().quit()
	
func fade_to(target : String) -> void:
	Transition.fade_to(target)

func play():
	MusicMenu.get_node("Music").stop()
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		var did_tuto = config.get_value("config","did_tuto", false)
		if did_tuto:
			Transition.fade_to("res://scenes/Gameplay.tscn")
			return
	config.set_value("config", "did_tuto", true)
	config.save("user://settings.cfg")
	Transition.fade_to("res://scenes/Tutorial.tscn")