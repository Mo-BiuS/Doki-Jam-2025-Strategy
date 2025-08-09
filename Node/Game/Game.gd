class_name Game extends Node2D

@export var playerActionMachine:PlayerActionMachine
@export var iaActionMachine:IaActionMachine

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var gameUI:GameUI

@export var cursor:SelectCursor

var loadArena:PackedScene = null

func _ready() -> void:
	if(loadArena != null):arenaHandler.loadArena(loadArena)
	else:
		arenaHandler.loadArena(preload("res://Node/Arena/StandardTestArena.tscn"))
		#arenaHandler.loadArena(preload("res://Node/Arena/LevelTest.tscn"))
		#arenaHandler.loadArena(preload("res://Node/Arena/IaBuyTest.tscn"))
	entityHandler.reset()
	buildingHandler.reset()
	cursor.setTile(buildingHandler.getCapitalPos(0))
	cursor.enable()

func endTurn():
	match VarGame.player[VarGame.teamTurn]:
		"player":pass
		"IA":iaActionMachine.end()
	
	gameUI.hideEscapeMenu()
	entityHandler.reactivateAllUnit()
	VarGame.teamTurn+=1
	if(VarGame.teamTurn == VarGame.player.size()):
		VarGame.teamTurn = 0
		VarGame.turn+=1
		for i in range(VarGame.player.size()):
			VarGame.gold[i]+=buildingHandler.getGoldFromPlayer(i)
	
	gameUI.refreshRessourcePanel()
	entityHandler.healUnitInAlliedBuilding()
	buildingHandler.uncaptureFreeBuilding()
	
	match VarGame.player[VarGame.teamTurn]:
		"player":
			cursor.controledByIa = false
			cursor.setTile(buildingHandler.getCapitalPos(VarGame.teamTurn))
			playerActionMachine.reset()
		"IA":
			cursor.controledByIa = true
			#cursor.setTile(buildingHandler.getCapitalPos(VarGame.teamTurn))
			iaActionMachine.initTurn()
			iaActionMachine.start()

func _on_game_ui_end_turn() -> void:
	endTurn()


func _on_building_handler_player_lost(int: Variant) -> void:
	playerActionMachine.isPlaying = false
	iaActionMachine.isPlaying = false
	cursor.disable()
