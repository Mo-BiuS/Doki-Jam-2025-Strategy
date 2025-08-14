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

signal buyUnit(n:int)
signal endTurn()
signal surrender()
signal toMainMenu
signal toNextMission

func _ready() -> void:
	ressourcePanel.custom_minimum_size.x = terrainInfoBox.size.x
	endGameScreen.hide()
	buyMenu.setVisible(false)
	escapeMenu.setVisible(false)

func _on_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
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
