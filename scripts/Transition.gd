extends CanvasLayer


onready var overlay = $ColorRect
# Called when the node enters the scene tree for the first time.

func fade_to(target):
	layer = 5
	$Tween.connect("tween_completed", self, "_unfade_to", [target])
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 0),
		Color(0, 0, 0, 1),
		 1.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _unfade_to(obj, key, target):
	print("unfade")
	if($ColorRect.color.a == 0):
		$Tween.disconnect("tween_completed", self, "_unfade_to")
		layer = 0
		return
	get_tree().change_scene(target)
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 1),
		Color(0, 0, 0, 0),
		 1.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()