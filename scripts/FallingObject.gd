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
	var transpose = []
	var copy_transpose = []
	var w = self.height
	var h = self.width

	for y in range(0,self.height):
		transpose.append([])
		copy_transpose.append([])
		for x in range(0,self.width):
			transpose[y].append(self.matrix[x][y])
			copy_transpose[y].append(self.matrix[x][y])

	var nw : int = int(w / 2)
	var nh : int = int(h / 2)

	for y in range(0,h):
		for x in range(0,nw):
			transpose[x][y] = copy_transpose[w-1-x][y]
			transpose[w-1-x][y] = copy_transpose[x][y]
			
	self.width = w
	self.height = h
	self.matrix = transpose

func rotate_left():
	var transpose = []
	var copy_transpose = []
	var w = self.height
	var h = self.width

	for y in range(0,self.height):
		transpose.append([])
		copy_transpose.append([])
		for x in range(0,self.width):
			transpose[y].append(self.matrix[x][y])
			copy_transpose[y].append(self.matrix[x][y])

	var nw : int = int(w / 2)
	var nh : int = int(h / 2)

	for x in range(0,w):
		for y in range(0,nh):
			transpose[x][y] = copy_transpose[x][h-1-y]
			transpose[x][h-1-y] = copy_transpose[x][y]

	self.width = w
	self.height = h
	self.matrix = transpose

