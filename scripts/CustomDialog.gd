extends VBoxContainer

func _draw():
	draw_rect(Rect2(-5, 0, get_size().x + 10, get_size().y), Color.white, true)
	draw_line(Vector2(-5, 0), Vector2(get_size().x + 5, 0), Color.black, 4.0)
	draw_line(Vector2(- 5, get_size().y), Vector2(get_size().x + 5, get_size().y), Color.black, 4.0)