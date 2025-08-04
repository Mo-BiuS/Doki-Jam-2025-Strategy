class_name BuildingHandler extends Node2D

const BUILDING_PACKED_CITY:PackedScene = preload("res://Node/Building/City.tscn")
const BUILDING_PACKED_BASE:PackedScene = preload("res://Node/Building/Base.tscn")
const BUILDING_PACKED_CAPITAL:PackedScene = preload("res://Node/Building/Capital.tscn")

@onready var arena:Arena = $"../ArenaHandler/Arena"

@onready var neutral:Node2D = $Neutral
@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

func _ready() -> void:
	for team in range(3):
		loadStartingBuilding(team,arena.getBuidingMap(team))
		
func loadStartingBuilding(team:int,list:Array):
	for i in list:
		var entity:Building = null
		match i[0] :
			0:entity = BUILDING_PACKED_CITY.instantiate()
			1:entity = BUILDING_PACKED_BASE.instantiate()
			2:entity = BUILDING_PACKED_CAPITAL.instantiate()
			_:print("Loading starting entity, error unit code")
		
		if entity != null:
			entity.team = team
			entity.position = Vector2i(i[1]*64+32,i[2]*64+32)
			match team:
				0:neutral.add_child(entity)
				1:team0.add_child(entity)
				2:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))
