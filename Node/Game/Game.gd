class_name Game extends Node2D

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var cursor:Cursor

var teamTurn = 0;

func _ready() -> void:
	arenaHandler.loadArena(preload("res://Node/Arena/StandardTestArena.tscn"))
	entityHandler.reset()
	buildingHandler.reset()
	cursor.setTile(buildingHandler.getCapitalPos(0))

func _process(delta: float) -> void:
	if(!cursor.isMoving() && Input.is_action_just_pressed("action")):
		var entity:Entity = entityHandler.getUnitFromTeamAt(teamTurn,cursor.tilePos)
		if(entity != null):
			print("Selected : ",entity)
