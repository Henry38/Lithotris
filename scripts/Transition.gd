extends CanvasLayer

export (float) var transition_time = 0.5
onready var overlay = $ColorRect
# Called when the node enters the scene tree for the first time.

func fade_to(target):
	overlay.set_size(get_viewport().size)
	$Tween.connect("tween_completed", self, "_unfade_to", [target])
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 0),
		Color(0, 0, 0, 1),
		 transition_time / 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _unfade_to(obj, key, target):
	if($ColorRect.color.a == 0):
		overlay.set_size(Vector2(0,0))
		$Tween.disconnect("tween_completed", self, "_unfade_to")
		return
	get_tree().change_scene(target)
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 1),
		Color(0, 0, 0, 0),
		 1.0, transition_time / 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()