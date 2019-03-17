const STATE_NORMAL = 1
const STATE_NEEDS_LITHO = 2
const STATE_SHOWS_LITHO = 3

var _state = STATE_NORMAL

func is_needing_litho():
	return _state == STATE_NEEDS_LITHO
	
func is_showing_litho():
	return _state == STATE_SHOWS_LITHO
	
func is_normal():
	return _state == STATE_NORMAL
	
	
func require_litho():
	_state = STATE_NEEDS_LITHO

func show_litho():
	_state = STATE_SHOWS_LITHO
	
func reset():
	_state = STATE_NORMAL