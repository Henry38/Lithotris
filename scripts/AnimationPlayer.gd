extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animaz = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if self.is_hovered():
		$AnimationPlayer.play("Fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):