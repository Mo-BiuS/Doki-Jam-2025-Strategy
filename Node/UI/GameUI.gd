class_name GameUI extends CanvasLayer

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@onready var buildingInfoBox:BuildingInfoBox = $MarginContainer/VBoxContainer/BuildingInfoBox
@onready var entityInfoBox:EntityInfoBox = $MarginContainer/VBoxContainer/EntityInfoBox
@onready var terrainInfoBox:TerrainInfoBox = $MarginContainer/VBoxContainer/TerrainInfoBox
@onready var buyMenu:BuyMenu = $BuyMenu
@onready var ressourcePanel:RessourcePanel = $MarginContainer2/RessourcePanel
@onready var escapeMenu:EscapeMenu = $EscapeMenu
@onready var endGameScreen:EndGameScreen = $EndGameScreen
@onready var battleUI:BattleUI = $MarginContainer/VBoxContainer/BattleUI

signal buyUnit(n:int)
signal endTurn()
signal surrender()
signal toMainMenu
signal toNextMission

var infoBoxHide = false

func _ready() -> void:
	ressourcePanel.custom_minimum_size.x = terrainInfoBox.size.x
	endGameScreen.hide()
	buyMenu.setVisible(false)
	escapeMenu.setVisible(false)
	battleUI.custom_minimum_size.x = terrainInfoBox.size.x
	battleUI.buildingHandler = buildingHandler
	battleUI.entityHandler = entityHandler
	battleUI.arenaHandler = arenaHandler
	battleUI.hide()

func _on_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
	if(!infoBoxHide):
		buildingInfoBox.refresh(buildingHandler,tPos)
		entityInfoBox.refresh(entityHandler, arenaHandler,tPos)
		terrainInfoBox.refresh(arenaHandler,buildingHandler,tPos)

func showBuildMenu():
	buyMenu.setVisible(true)
func hideBuildMenu():
	buyMenu.setVisible(false)

func refreshRessourcePanel():
	ressourcePanel.refresh()

func _on_buy_menu_buy_unit(n: int) -> void:
	buyUnit.emit(n)

func showEscapeMenu():
	escapeMenu.setVisible(true)
func hideEscapeMenu():
	escapeMenu.setVisible(false)

func displayEndGameScreen():
	for i in get_children():i.hide()
	endGameScreen.display()

func _on_escape_menu_end_turn() -> void:
	endTurn.emit()


func _on_escape_menu_surrender() -> void:
	surrender.emit()


func _on_end_game_screen_to_main_menu() -> void:
	toMainMenu.emit()


func _on_end_game_screen_to_next_mission() -> void:
	toNextMission.emit()

var starter:Vector2i = Vector2i(-1,-1)
func _on_select_cursor_select_action_at(initiator: Vector2i, target: Vector2i) -> void:
	battleUI.show()
	buildingInfoBox.hide()
	entityInfoBox.hide()
	terrainInfoBox.hide()
	infoBoxHide=true
	if(initiator != Vector2i(-1,-1)):starter = initiator
	battleUI.refresh(starter,target)

func _on_select_cursor_attack_at(tpos: Vector2i) -> void:
	buildingInfoBox.show()
	entityInfoBox.show()
	terrainInfoBox.show()
	infoBoxHide=false
	starter = Vector2i(-1,-1)
	battleUI.hide()
