class_name Game extends Node2D

@export var playerActionMachine:PlayerActionMachine
@export var iaActionMachine:IaActionMachine

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var gameUI:GameUI
@export var gameDialogUI:GameDialogUI

@export var cursor:SelectCursor

@export var dokiMusic:AudioStreamPlayer
@export var triksterMusic:AudioStreamPlayer

signal toMainMenu
signal toNextMission

var loadArena:PackedScene = preload("res://Node/Arena/SimpleArena.tscn")

func _ready() -> void:
	VarGame.reset()
	arenaHandler.loadArena(loadArena)
	entityHandler.reset()
	buildingHandler.reset()
	cursor.setTile(buildingHandler.getCapitalPos(0))
	CONST_CAMPAIGN.dialogPointer = 0
	if(CONST_CAMPAIGN.isInCampaign && CONST_CAMPAIGN.hasIntroLeft()):
		cursor.disable()
		gameUI.hide()
		gameDialogUI.show()
		gameDialogUI.startIntro()
	else:
		start()

func start():
	gameDialogUI.hide()
	gameUI.show()
	cursor.enable()
	
	if(VarGame.teamTurn >= 0):
		match VarGame.teamTurn:
			0:
				dokiMusic.play(0)
				triksterMusic.stop()
			1:
				dokiMusic.stop()
				triksterMusic.play(0)

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
			#cursor.setTile(buildingHandler.getCapitalPos(VarGame.teamTurn))
			playerActionMachine.reset()
		"IA":
			cursor.controledByIa = true
			#cursor.setTile(buildingHandler.getCapitalPos(VarGame.teamTurn))
			iaActionMachine.initTurn()
			iaActionMachine.start()
	
	if(VarGame.teamTurn >= 0):
		match VarGame.teamTurn:
			0:
				dokiMusic.play(0)
				triksterMusic.stop()
			1:
				dokiMusic.stop()
				triksterMusic.play(0)


func _on_game_ui_end_turn() -> void:
	endTurn()
func _on_building_handler_player_lost(int: Variant) -> void:
	VarGame.winner = VarGame.teamTurn
	playerActionMachine.isPlaying = false
	iaActionMachine.isPlaying = false
	cursor.disable()
	
	if(VarGame.winner == 0 && CONST_CAMPAIGN.isInCampaign && CONST_CAMPAIGN.hasOutroLeft()):
		gameUI.hide()
		gameDialogUI.show()
		gameDialogUI.startOutro()
	else:displayEndGameScreen()
func _on_game_ui_surrender() -> void:
	VarGame.winner = (VarGame.teamTurn+1)%2
	playerActionMachine.isPlaying = false
	iaActionMachine.isPlaying = false
	cursor.disable()
	displayEndGameScreen()

func displayEndGameScreen():
	gameUI.show()
	gameDialogUI.hide()
	gameUI.displayEndGameScreen()

func _on_game_ui_to_main_menu() -> void:
	toMainMenu.emit()


func _on_doki_music_finished() -> void:
	dokiMusic.play(0)
func _on_trikster_music_finished() -> void:
	triksterMusic.play(0)


func _on_game_ui_to_next_mission() -> void:
	toNextMission.emit()
