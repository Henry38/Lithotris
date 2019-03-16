extends Control

onready var progress = $ColorRect/TextureProgress

func progress(prog: int):
	if progress.value == progress.max_value:
		return
	progress.value = min(progress.max_value, progress.value + prog)
