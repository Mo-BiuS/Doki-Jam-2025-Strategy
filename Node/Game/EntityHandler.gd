class_name EntityHandler extends Node2D

var packed = [
	load("res://Node/Entity/DragoonEgg.tscn"),
	load("res://Node/Entity/DragoonChick.tscn"),
	load("res://Node/Entity/DragoonLong.tscn"),
	load("res://Node/Entity/DragoonBeeg.tscn")
]

@export var playerActionMachine:PlayerActionMachine
@export var gameUI:GameUI
@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var cursor:SelectCursor


@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

signal entityBought

func reset() -> void:
	for i in team0.get_children():i.queue_free()
	for i in team1.get_children():i.queue_free()
	for team in range(2):
		loadStartingEntity(team,arenaHandler.arena.getEntityMap(team))

func loadStartingEntity(team:int,list:Array):
	for i in list:
		var entity:Entity = packed[i[0]].instantiate()
		
		if entity != null:
			entity.team = team
			entity.arena = arenaHandler.arena
			entity.entityHandler = self
			entity.setPosition(Vector2i(i[1],i[2]))
			match team:
				0:team0.add_child(entity)
				1:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))

func getUnitFromTeamAt(team:int, pos:Vector2i)->Entity:
	var list:Node2D
	match team:
		0:list = team0
		1:list = team1
	for i in list.get_children():
		if i.tilePos == pos: return i
	var rep:Entity = null
	return rep

func reactivateAllUnit():
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		i.activate()
	

func getUnitAt(pos:Vector2i)->Entity:
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i.tilePos == pos: return i
	var rep:Entity = null
	return rep

func healUnitInAlliedBuilding():
	var list:Array
	match VarGame.teamTurn:
		0:list = team0.get_children()
		1:list = team1.get_children()
	
	for i in list:
		var b:Building = buildingHandler.getBuildingAtPos(i.tilePos)
		if(b != null && b.team-1 == i.team):i.heal()

func getWeightedTeam()->Array:
	var team:Array[Entity] = getAllFromPlayingTeam()
	var rep:Array = [0.,0.,0.,0.]
	for i in team:
		if(i is DragoonEgg):rep[0]+=1
		elif(i is DragoonChick):rep[1]+=1
		elif(i is DragoonLong):rep[2]+=1
		elif(i is DragoonBeeg):rep[3]+=1
	for i in range(rep.size()):
		rep[i]/=CONST_UNIT.array[i][6]
		rep[i]+=randf_range(0, CONST_UNIT.array[i][6])
	return rep

func isThereEnnemiesEntityAround(pos:Vector2i, size:int)->bool:
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i is Entity && i.team != VarGame.teamTurn:
			if(pos.distance_to(i.tilePos) <= size):
				return true
	return false

func getAllFromPlayingTeam()->Array[Entity]:
	var rep:Array[Entity]
	var list
	match VarGame.teamTurn:
		0:list = team0.get_children()
		1:list = team1.get_children()
	for i in list:
		if i is Entity:rep.append(i)
	return rep
func getAllFromEnnemyTeam()->Array[Entity]:
	var rep:Array[Entity]
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i is Entity && i.team != VarGame.teamTurn:rep.append(i)
	return rep
func getAllFromPlayingTeamOrdered()->Array[Entity]:
	var rep:Array[Entity]
	var list
	match VarGame.teamTurn:
		0:list = team0.get_children()
		1:list = team1.get_children()
	var capital:Capital = buildingHandler.getCapitalFromTeam(VarGame.teamTurn)
	var unorderedResponse:Array
	for i in list:
		if i is Entity:unorderedResponse.append([i,i.tilePos.distance_to(capital.tilePos)])
	
	var asc = !isThereEnnemiesEntityAround(capital.tilePos, 5)
	sortEntity(unorderedResponse, asc)
	
	for i in unorderedResponse:
		rep.append(i[0])
	
	return rep

#PUTAIN DE TRI A BULLE DE MERDE
#Copié collé de BuildingHandler
func sortEntity(b:Array, asc:bool):
	var i = 0;
	while(i < b.size()-1):
		if((asc && b[i][1] < b[i+1][1]) || (!asc && b[i][1] > b[i+1][1])):
			var tmp = b[i]
			b[i] = b[i+1]
			b[i+1] = tmp
			if(i > 0):i-=1
		else:i+=1
	

func _on_game_ui_buy_unit(n: int) -> void:
	var entity:Entity = packed[n].instantiate()
	entity.team = VarGame.teamTurn
	entity.arena = arenaHandler.arena
	entity.entityHandler = self
	VarGame.unitProduced[VarGame.teamTurn][n]+=1
	entity.setPosition(cursor.tilePos)
	match VarGame.teamTurn:
		0:team0.add_child(entity)
		1:team1.add_child(entity)
	entity.desactivate()
	VarGame.gold[VarGame.teamTurn] -= CONST_UNIT.array[n][5]
	gameUI.refreshRessourcePanel()
	gameUI.hideBuildMenu()
	playerActionMachine.reset()
	
