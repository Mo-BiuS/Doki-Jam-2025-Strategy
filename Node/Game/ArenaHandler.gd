class_name ArenaHandler extends Node2D

var arena:Arena
@export var entityHandler:EntityHandler

func loadArena(packedArena:PackedScene):
	if arena != null : remove_child(arena)
	arena = packedArena.instantiate()
	add_child(arena)

func calculateAreaMap(e: Entity):
	e.areaDict.clear()
	
	var posList = [e.tilePos]
	e.areaDict[e.tilePos] = 0
	while posList.size() > 0:
		var pos:Vector2i = posList.pop_front()
		var cCost = e.areaDict[pos]
		
		for p in [Vector2i(-1,0), Vector2i(1,0), Vector2i(0,-1), Vector2i(0,1)]:
			var entityAt:Entity = entityHandler.getUnitAt(pos+p)
			if arena.isIn(pos+p) && (entityAt == null || entityAt.team == e.team):
				var dc = arena.getDeplacementCostAt(pos+p)
				if dc > 0:
					var nc = cCost + dc
					if !e.areaDict.has(pos+p) or nc < e.areaDict[pos+p]:
						e.areaDict[pos+p] = nc
						posList.push_back(pos+p)
