class_name EntityHandler extends Node2D

const DRAGOON_PACKED_EGG:PackedScene = preload("res://Node/Entity/DragoonEgg.tscn")
const DRAGOON_PACKED_CHICK:PackedScene = preload("res://Node/Entity/DragoonChick.tscn")
const DRAGOON_PACKED_LONG:PackedScene = preload("res://Node/Entity/DragoonLong.tscn")
const DRAGOON_PACKED_BEEG:PackedScene = preload("res://Node/Entity/DragoonBeeg.tscn")

@onready var arena:Arena = $"../ArenaHandler/Arena"
@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

func _ready() -> void:
	for team in range(2):
		loadStartingEntity(team,arena.getEntityMap(team))

func loadStartingEntity(team:int,list:Array):
	for i in list:
		var entity:Entity = null
		match i[0] :
			0:entity = DRAGOON_PACKED_EGG.instantiate()
			1:entity = DRAGOON_PACKED_CHICK.instantiate()
			2:entity = DRAGOON_PACKED_LONG.instantiate()
			3:entity = DRAGOON_PACKED_BEEG.instantiate()
			_:print("Loading starting entity, error unit code")
		
		if entity != null:
			entity.team = team
			entity.position = Vector2i(i[1]*64+32,i[2]*64+32)
			match team:
				0:team0.add_child(entity)
				1:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))
