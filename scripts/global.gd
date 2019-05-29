extends Node

const EMPTY_TILE               = -1
const BACKGROUND_TILE          = 0
const CONDUCTOR_TILE           = 1
const ISOLATOR_TILE            = 2
const LIGHTENED_CONDUCTOR_TILE = 3
const STARTING_TILE            = 4
const ENDING_TILE              = 5
const RESIN_CLICKED_TILE       = 6
const RESIN_TILE               = 7
const WALL_TILE                = 8

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func is_conductor(v : int) -> bool:
	return v == CONDUCTOR_TILE or v == LIGHTENED_CONDUCTOR_TILE
	
func is_useless(v : int) -> bool:
	return v <= 0
