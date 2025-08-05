class_name MovementArrow extends TileMapLayer

@export var arenaHandler:ArenaHandler
@export var entityHandler:EntityHandler

@export var cursor:SelectCursor
@export var movementArea:MovementArea

var selectedEntity:Entity


func refresh():
	clear()
	if(selectedEntity != null && movementArea.get_cell_tile_data(cursor.tilePos) != null && entityHandler.getUnitAt(cursor.tilePos) == null):
		var traceDict:Dictionary
		
		emission(traceDict, selectedEntity.tilePos, 0)
		
		var mvmMap:Array[Vector2i]
		
		trace(mvmMap,traceDict,cursor.tilePos,selectedEntity.tilePos)
		
		selectedEntity.mvmMap = mvmMap
		set_cells_terrain_connect(mvmMap,0,0)

func emission(traceDict:Dictionary, pos:Vector2i, i:int):
	traceDict[pos] = i
	for p in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
		if(arenaHandler.arena.isIn(pos+p) && movementArea.get_cell_tile_data(pos+p) != null):
			var ni = i + arenaHandler.arena.getDeplacementCostAt(pos+p)
			if(!traceDict.has(pos+p) || traceDict[pos+p] > ni):
				emission(traceDict,pos+p,ni)

func trace(mvmMap:Array[Vector2i],traceDict:Dictionary,start:Vector2i,dest:Vector2i):
	mvmMap.append(start)
	if(start != dest):
		var dir:Array[Vector2i]
		for p in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
			if(traceDict.has(start+p)):dir.append(start+p)
		var m:int = 1000000000
		for p in dir:
			m = min(m,traceDict[p])
		for p in dir:
			if traceDict[p] == m:
				trace(mvmMap,traceDict,p,dest)
				break
	pass
