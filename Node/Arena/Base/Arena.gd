class_name Arena extends Node2D

@onready var tiles:TileMapLayer = $Tiles
@onready var roads:TileMapLayer = $Road
@onready var entitySpawn:TileMapLayer = $EntitySpawn
@onready var buildingSpawn:TileMapLayer = $BuildingSpawn

@onready var neutral:Node =$"../../BuildingHandler/Neutral"

func _ready() -> void:
	entitySpawn.hide()
	buildingSpawn.hide()

#Array [ Array [ type, posX, posY ] ]
func getEntityMap(player:int):
	var list:Array
	
	for i in entitySpawn.get_used_cells():
		var tileData:TileData = entitySpawn.get_cell_tile_data(i)
		if(tileData.terrain_set == player):
			list.append([tileData.terrain, i.x, i.y])
	
	return list
	
func getBuidingMap(player:int):
	var list:Array
	
	for i in buildingSpawn.get_used_cells():
		var tileData:TileData = buildingSpawn.get_cell_tile_data(i)
		if(tileData.terrain_set == player):
			list.append([tileData.terrain, i.x, i.y])
	
	return list

func getDeplacementCostAt(pos:Vector2i)->int:
	var tileData:TileData = tiles.get_cell_tile_data(pos)
	var roadData:TileData = roads.get_cell_tile_data(pos)
	var buildingData:TileData = buildingSpawn.get_cell_tile_data(pos)
	var terrainData = CONST_TERRAIN.ARRAY[tileData.terrain]
	if roadData != null : return 1
	elif buildingData != null : return 4
	else:return terrainData[1]

func getDefenceAt(pos:Vector2i)->int:
	var tileData:TileData = tiles.get_cell_tile_data(pos)
	var roadData:TileData = roads.get_cell_tile_data(pos)
	var buildingData:TileData = buildingSpawn.get_cell_tile_data(pos)
	var terrainData = CONST_TERRAIN.ARRAY[tileData.terrain]
	if roadData != null : return 0
	elif buildingData != null : return 2
	else:return terrainData[2]


func isIn(pos:Vector2i)->bool:
	return tiles.get_cell_tile_data(pos) != null
func getCenter()->Vector2i:
	return tiles.get_used_rect().get_center()
