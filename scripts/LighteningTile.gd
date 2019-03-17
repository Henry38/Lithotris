
func lightenBlock(tilemap, block):
	
	var tiles = []
	
	for x in range(0,block.width):
		for y in range(0, block.height):
			var id = block.get_cell(x,y)
			if id == tilemap.g.CONDUCTOR_TILE:
				tiles.append(Vector2(block.x + x, block.y + y))

	var find_lightened_conductor = false
	
	for pos in tiles:
		# 1. trouver si un voisin est allume
		var directions = [
			Vector2(pos.x - 1, pos.y),
			Vector2(pos.x + 1, pos.y),
			Vector2(pos.x, pos.y - 1),
			Vector2(pos.x, pos.y + 1)
		]
		
		for dir in directions:
			var id = tilemap.get_cellv(dir)
			if id == tilemap.g.LIGHTENED_CONDUCTOR_TILE or id == tilemap.g.STARTING_TILE:
				find_lightened_conductor = true
	
	if find_lightened_conductor:
		# 2. allumer tous les block connectes
		while tiles.size() > 0:
			var pos = tiles.pop_back()
			
			tilemap.set_cellv(pos, tilemap.g.LIGHTENED_CONDUCTOR_TILE)
			
			var directions = [
				Vector2(pos.x - 1, pos.y),
				Vector2(pos.x + 1, pos.y),
				Vector2(pos.x, pos.y - 1),
				Vector2(pos.x, pos.y + 1)
			]
			
			# ajouter les voisins non allumes conducteurs
			for dir in directions:
				var id = tilemap.get_cellv(dir)
				if id == tilemap.g.CONDUCTOR_TILE:
					if not tiles.has(dir):
						tiles.append(dir)
