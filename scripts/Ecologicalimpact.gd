extends Control

signal max_reached

onready var progress = $Node/ColorRect/TextureProgress

func progress(prog: int):
	if progress.value == progress.max_value:
		return
	progress.value = min(progress.max_value, progress.value + prog)
	if progress.value == progress.max_value:
		emit_signal("max_reached")
