class_name MovementArea extends TileMapLayer

@export var arenaHandler:ArenaHandler
@export var entityHandler:EntityHandler
var selectedEntity:Entity

var areaDict:Dictionary

func refresh():
	clear()
	areaDict.clear()
	if selectedEntity != null :
		emission(selectedEntity.tilePos,0)
		set_cells_terrain_connect(areaDict.keys(),0,0)

func emission(pos:Vector2i, mvm:int):
	if(!areaDict.has(pos) || areaDict[pos] > mvm):
		areaDict[pos] = mvm
		if(mvm < selectedEntity.mvm):
			for p in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
				if(arenaHandler.arena.isIn(pos+p)):
					var e:Entity = entityHandler.getUnitAt(pos+p)
					if(e == null || e.team == selectedEntity.team):
						var dc = arenaHandler.arena.getDeplacementCostAt(pos+p)
						if(dc > 0):
							emission(pos+p, mvm+dc)
