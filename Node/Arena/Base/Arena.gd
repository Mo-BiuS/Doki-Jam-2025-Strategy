class_name Arena extends Node2D

@onready var entitySpawn:TileMapLayer = $EntitySpawn

func _ready() -> void:
	entitySpawn.hide()

#Array [ Array [ type, posX, posY ] ]
func getEntityMap(player:int):
	var list:Array
	
	for i in entitySpawn.get_used_cells():
		var tileData:TileData = entitySpawn.get_cell_tile_data(i)
		if(tileData.terrain_set == player):
			list.append([tileData.terrain, i.x, i.y])
	
	return list
