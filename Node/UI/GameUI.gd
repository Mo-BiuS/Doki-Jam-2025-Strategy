class_name GameUI extends CanvasLayer

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler


@onready var buildingInfoBox:BuildingInfoBox = $MarginContainer/VBoxContainer/BuildingInfoBox
@onready var entityInfoBox:EntityInfoBox = $MarginContainer/VBoxContainer/EntityInfoBox
@onready var terrainInfoBox:TerrainInfoBox = $MarginContainer/VBoxContainer/TerrainInfoBox
@onready var buyMenu:BuyMenu = $BuyMenu

func _ready() -> void:
	buyMenu.setVisible(false)

func _on_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
	buildingInfoBox.refresh(buildingHandler,tPos)
	entityInfoBox.refresh(entityHandler,tPos)
	terrainInfoBox.refresh(arenaHandler,buildingHandler,tPos)

func showBuildMenu():
	buyMenu.setVisible(true)
func hideBuildMenu():
	buyMenu.setVisible(false)
