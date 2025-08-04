class_name MovementArea extends TileMapLayer

@export var arenaHandler:ArenaHandler
@export var entityHandler:EntityHandler
var selectedEntity:Entity

func refresh():
	clear()
	if selectedEntity != null :
		var area:Array[Vector2i]
		chase(area, selectedEntity.tilePos, selectedEntity.mvm)
		set_cells_terrain_connect(area,0,0)

func chase(area:Array[Vector2i], pos:Vector2i, power:int):
	if(!area.has(pos)):area.append(pos)
	if(power>0):
		for p in [Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)]:
			if(arenaHandler.arena.isIn(pos+p)):
				var entity:Entity = entityHandler.getUnitAt(pos+p)
				if(entity == null || entity.team == selectedEntity.team):
					var mp = arenaHandler.arena.getDeplacementCostAt(pos+p)
					if(mp != -1):
						chase(area, pos+p, power-mp)
