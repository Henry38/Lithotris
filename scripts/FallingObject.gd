var _cellId
var _cellPositions

func _init(cellId, cellPOsitions):
	self._cellId = cellId
	self._cellPositions = cellPOsitions
	
func cell_id():
	return _cellId
	
func cell_positions():
	return _cellPositions