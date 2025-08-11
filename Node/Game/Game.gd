class_name Game extends Node2D

@export var playerActionMachine:PlayerActionMachine
@export var iaActionMachine:IaActionMachine

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var gameUI:GameUI

@export var cursor:SelectCursor

@export var backgroundMusic:AudioStreamPlayer

var loadArena:PackedScene = preload("res://Node/Arena/SimpleArena.tscn")

func _ready() -> void:
	arenaHandler.loadArena(loadArena)
	entityHandler.reset()
	buildingHandler.reset()
	cursor.setTile(buildingHandler.getCapitalPos(0))
	cursor.enable()
	
	if(VarGame.teamTurn >= 0):
		backgroundMusic.stream = VarGame.bgmMusic[VarGame.teamTurn][1]
		backgroundMusic.volume_db = VarGame.bgmMusic[VarGame.teamTurn][0]
		backgroundMusic.play()

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
	
	backgroundMusic.stream = VarGame.bgmMusic[VarGame.teamTurn][1]
	backgroundMusic.volume_db = VarGame.bgmMusic[VarGame.teamTurn][0]
	backgroundMusic.play()

func _on_game_ui_end_turn() -> void:
	endTurn()


func _on_building_handler_player_lost(int: Variant) -> void:
	playerActionMachine.isPlaying = false
	iaActionMachine.isPlaying = false
	cursor.disable()


func _on_background_music_finished() -> void:
	backgroundMusic.play()
