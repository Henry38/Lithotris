var _cellId
var _cellPositions

var x
var y
var width
var height

var matrix

func _init(cellId, cellPositions):
	self._cellId = cellId
	self._cellPositions = cellPositions
	self.x = 0
	self.y = 0
	
	var min_x = cellPositions[0].x
	var min_y = cellPositions[0].y
	var max_x = cellPositions[0].x
	var max_y = cellPositions[0].y
	
	for p in cellPositions:
		if p.x < min_x:
			min_x = p.x
		if p.x > max_x:
			max_x = p.x
		if p.y < min_y:
			min_y = p.y
		if p.y > max_y:
			max_y = p.y
			
		self.width = (max_x - min_x) + 1
		self.height = (max_y - min_y) + 1

	self.matrix = []
	
	for x in range(0,self.width):
		self.matrix.append([])
		for y in range(0,self.height):
			self.matrix[x].append(-1)
			
	for p in cellPositions:
		var x = p.x
		var y = p.y
		self.matrix[x][y] = cellId
				
func cell_id():
	return _cellId
	
func get_cell(x, y):
	if x < 0 or x >= self.width or y < 0 or y >= self.height:
		return -1
		
	return self.matrix[x][y]

func cell_position():
	return Vector2(x, y)

func rotate_right():
	pass
		
func rotate_left():
	pass
	