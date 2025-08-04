class_name TerrainInfoBox extends PanelContainer

@export var nameLabel:Label
@export var movingCostLabel:Label
@export var defenseBonusLabel:Label
@export var visibilityMalusLabel:Label

func refresh(arenaHandler:ArenaHandler,buildingHandler:BuildingHandler, pos:Vector2i)->void:
	var tileData:TileData = arenaHandler.arena.tiles.get_cell_tile_data(pos)
	var roadData:TileData = arenaHandler.arena.roads.get_cell_tile_data(pos)
	var building:Building = buildingHandler.getBuildingAtPos(pos)
	
	var hasRoad:bool = roadData != null
	var hasBuilding:bool = building != null
	var terrainData = CONST_TERRAIN.ARRAY[tileData.terrain]
	
	if(hasRoad):nameLabel.text = "Road"
	elif(!hasBuilding):nameLabel.text = terrainData[0]
	else:
		if(building is City):nameLabel.text = "City"
		elif(building is Base):nameLabel.text = "Base"
		elif(building is Capital):nameLabel.text = "Capital"
	
	if(hasRoad):movingCostLabel.text = "1"
	elif(terrainData[1] == -1):movingCostLabel.text = "impassable"
	else:movingCostLabel.text = str(terrainData[1])
	
	if(hasBuilding):defenseBonusLabel.text = "4"
	elif(hasRoad):defenseBonusLabel.text = "0"
	elif(terrainData[1] == -1):defenseBonusLabel.text = "None"
	else:defenseBonusLabel.text = str(terrainData[2])
	
	if(hasBuilding):visibilityMalusLabel.text = "4"
	elif(hasRoad):visibilityMalusLabel.text = "1"
	else:visibilityMalusLabel.text = str(terrainData[3])
