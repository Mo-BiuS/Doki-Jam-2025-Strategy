class_name EntityHandler extends Node2D

@export var playerActionMachine:PlayerActionMachine
@export var gameUI:GameUI
@export var arenaHandler:ArenaHandler
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
		var entity:Entity = CONST_UNIT.packed[i[0]].instantiate()
		
		if entity != null:
			entity.team = team
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

func getUnitAt(pos:Vector2i)->Entity:
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i.tilePos == pos: return i
	var rep:Entity = null
	return rep
	

func _on_game_ui_buy_unit(n: int) -> void:
	var entity:Entity = CONST_UNIT.packed[n].instantiate()
	entity.team = VarGame.teamTurn
	entity.setPosition(cursor.tilePos)
	match VarGame.teamTurn:
		0:team0.add_child(entity)
		1:team1.add_child(entity)
	
	VarGame.gold -= CONST_UNIT.array[n][5]
	gameUI.refreshRessourcePanel()
	gameUI.hideBuildMenu()
	playerActionMachine.reset()
	
