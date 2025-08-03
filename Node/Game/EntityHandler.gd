extends Node2D

const DRAGOON_PACKED_EGG = preload("res://Node/Entity/DragoonEgg.tscn")
const DRAGOON_PACKED_CHICK = preload("res://Node/Entity/DragoonChick.tscn")
const DRAGOON_PACKED_LONG = preload("res://Node/Entity/DragoonLong.tscn")
const DRAGOON_PACKED_BEEG = preload("res://Node/Entity/DragoonBeeg.tscn")

@onready var arena:Arena = $"../ArenaHandler/Arena"

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
			add_child(entity)
