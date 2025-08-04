class_name Arena extends Node2D

@onready var tiles:TileMapLayer = $Tiles
@onready var entitySpawn:TileMapLayer = $EntitySpawn
@onready var buildingSpawn:TileMapLayer = $BuildingSpawn

@onready var neutral:Node =$"../../BuildingHandler/Neutral"
@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

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

func isIn(pos:Vector2i)->bool:
	return tiles.get_cell_tile_data(pos) != null
func getCenter()->Vector2i:
	return tiles.get_used_rect().get_center()
	
