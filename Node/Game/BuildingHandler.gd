class_name BuildingHandler extends Node2D

const BUILDING_PACKED_CITY:PackedScene = preload("res://Node/Building/City.tscn")
const BUILDING_PACKED_BASE:PackedScene = preload("res://Node/Building/Base.tscn")
const BUILDING_PACKED_CAPITAL:PackedScene = preload("res://Node/Building/Capital.tscn")

@export var arenaHandler:ArenaHandler
@export var entityHandler:EntityHandler

@onready var neutral:Node2D = $Neutral
@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

signal playerLost(int)

func reset() -> void:
	for i in neutral.get_children():i.queue_free()
	for i in team0.get_children():i.queue_free()
	for i in team1.get_children():i.queue_free()
	for team in range(3):
		loadStartingBuilding(team,arenaHandler.arena.getBuidingMap(team))
		
func loadStartingBuilding(team:int,list:Array):
	for i in list:
		var entity:Building = null
		match i[0] :
			0:entity = BUILDING_PACKED_CITY.instantiate()
			1:entity = BUILDING_PACKED_BASE.instantiate()
			2:entity = BUILDING_PACKED_CAPITAL.instantiate()
			_:print("Loading starting entity, error unit code")
		
		if entity != null:
			entity.changedTeam.connect(buildingChangedTeam)
			entity.team = team
			entity.setPosition(Vector2i(i[1],i[2]))
			match team:
				0:neutral.add_child(entity)
				1:team0.add_child(entity)
				2:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))

func getCapitalPos(player:int)->Vector2i:
	var list:Node2D
	match player:
		0:list = team0
		1:list = team1
		_:print("get capital error player index")
	for i in list.get_children():
		if i is Capital:
			return i.position/64
	return Vector2i(-1,-1)

func getCapitalFromTeam(player:int)->Capital:
	var list:Node2D
	match player:
		0:list = team0
		1:list = team1
		_:print("get capital error player index")
	for i in list.get_children():
		if i is Capital:
			return i
	return null

func getBaseFromTeamAt(team:int, pos:Vector2i)->Base:
	var list:Node2D
	match team:
		0:list = team0
		1:list = team1
	for i in list.get_children():
		if i is Base && i.tilePos == pos: return i
	return null

func getBuildingAtPos(pos:Vector2i) -> Building:
	var allStar:Array
	allStar.append_array(neutral.get_children())
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())

	for b in allStar:
		if b.tilePos == pos : return b
	return null

func buildingChangedTeam(building:Building):
	if(neutral.get_children().has(building)): neutral.remove_child(building)
	elif(team0.get_children().has(building)):team0.remove_child(building)
	elif(team1.get_children().has(building)):team1.remove_child(building)
	match building.team:
		0:neutral.add_child(building)
		1:team0.add_child(building)
		2:team1.add_child(building)
	if(building is Capital):
		playerLost.emit(building.team-1)

func getGoldFromPlayer(i) -> int:
	var rep = 0
	var team:Array
	match (i+1):
		1:team = team0.get_children()
		2:team = team1.get_children()
	for j in team:
		if j is Capital:rep+=400
		if j is City:rep+=100
	return rep

func uncaptureFreeBuilding()->void:
	
	var allStar:Array
	allStar.append_array(neutral.get_children())
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())

	for b in allStar:
		var entity:Entity = entityHandler.getUnitAt(b.tilePos)
		if(b.capture != 10 && (entity == null || entity.team == b.team-1)):
			b.capture = 10
			b.teamCapturng = -1
			b.captureCounterContainer.hide()
func getAllFromEnnemyTeam()->Array[Building]:
	var rep:Array[Building]
	var allStar:Array
	allStar.append_array(neutral.get_children())
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i is Building && i.team-1 != VarGame.teamTurn:rep.append(i)
	return rep

func getAllBaseFromPlayingTeamOrdered()->Array[Base]:
	var rep:Array[Base]
	var list
	match VarGame.teamTurn:
		0:list = team0.get_children()
		1:list = team1.get_children()
	var capital:Capital = getCapitalFromTeam(VarGame.teamTurn)
	var unorderedResponse:Array
	for i in list:
		if i is Base:unorderedResponse.append([i,i.tilePos.distance_to(capital.tilePos)])
	
	var asc = !entityHandler.isThereEnnemiesEntityAround(capital.tilePos, 5)
	sortBase(unorderedResponse, asc)
	
	for i in unorderedResponse:
		rep.append(i[0])
	
	return rep

#PUTAIN DE TRI A BULLE DE MERDE
#J'ai pas le temps, j'ai fait simple et sans IA
func sortBase(b:Array, asc:bool):
	var i = 0;
	while(i < b.size()-1):
		if((asc && b[i][1] < b[i+1][1]) || (!asc && b[i][1] > b[i+1][1])):
			var tmp = b[i]
			b[i] = b[i+1]
			b[i+1] = tmp
			if(i > 0):i-=1
		else:i+=1
