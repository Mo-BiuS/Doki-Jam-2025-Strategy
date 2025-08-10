class_name MovementArrow extends TileMapLayer

@export var arenaHandler:ArenaHandler
@export var entityHandler:EntityHandler

@export var cursor:SelectCursor
@export var movementArea:MovementArea

var selectedEntity:Entity
var mvmMap:Array[Vector2i]

func refresh():
	clear()
	mvmMap.clear()
	if(selectedEntity != null && movementArea.get_cell_tile_data(cursor.tilePos) != null && entityHandler.getUnitAt(cursor.tilePos) == null):
		trace(cursor.tilePos)
		selectedEntity.mvmMap = mvmMap
		set_cells_terrain_connect(mvmMap,0,0)

func trace(pos:Vector2i):
	mvmMap.append(pos)
	if(pos != selectedEntity.tilePos):
		var validDirection:Array
		for i in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
			if(movementArea.areaDict.has(pos+i)):validDirection.append(i)
		var minAround = 16384
		for i in validDirection:
			minAround = min(minAround,movementArea.areaDict[pos+i])
		for i in validDirection:
			if(movementArea.areaDict[pos+i] == minAround):
				trace(pos+i)
				break
	
	
