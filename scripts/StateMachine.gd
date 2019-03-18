const STATE_NORMAL = 1
const STATE_NEEDS_LITHO = 2
const STATE_SHOWS_LITHO = 3
const STATE_SHOW_VICTORY = 4
const STATE_SHOW_GAME_OVER = 5

var _state = STATE_NORMAL

func is_needing_litho():
	return _state == STATE_NEEDS_LITHO
	
func is_showing_litho():
	return _state == STATE_SHOWS_LITHO
	
func is_normal():
	return _state == STATE_NORMAL
	
func is_show_victory():
	return _state == STATE_SHOW_VICTORY

func is_show_game_over():
	return _state == STATE_SHOW_GAME_OVER	
	
func require_litho():
	_state = STATE_NEEDS_LITHO

func show_litho():
	_state = STATE_SHOWS_LITHO
	
func reset():
	_state = STATE_NORMAL
	
func show_victory():
	_state = STATE_SHOW_VICTORY
	
func show_game_over():
	_state = STATE_SHOW_GAME_OVER