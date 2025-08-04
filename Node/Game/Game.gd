class_name Game extends Node2D

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var cursor:Cursor

func _ready() -> void:
	arenaHandler.loadArena(preload("res://Node/Arena/StandardTestArena.tscn"))
	entityHandler.reset()
	buildingHandler.reset()
	cursor.setTile(buildingHandler.getCapitalPos(0))
