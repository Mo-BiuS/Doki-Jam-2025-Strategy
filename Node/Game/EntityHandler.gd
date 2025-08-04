class_name EntityHandler extends Node2D

const DRAGOON_PACKED_EGG:PackedScene = preload("res://Node/Entity/DragoonEgg.tscn")
const DRAGOON_PACKED_CHICK:PackedScene = preload("res://Node/Entity/DragoonChick.tscn")
const DRAGOON_PACKED_LONG:PackedScene = preload("res://Node/Entity/DragoonLong.tscn")
const DRAGOON_PACKED_BEEG:PackedScene = preload("res://Node/Entity/DragoonBeeg.tscn")

@export var arenaHandler:ArenaHandler

@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

func reset() -> void:
	for i in team0.get_children():i.queue_free()
	for i in team1.get_children():i.queue_free()
	for team in range(2):
		loadStartingEntity(team,arenaHandler.arena.getEntityMap(team))

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
			entity.setPosition(Vector2i(i[1],i[2]))
			match team:
				0:team0.add_child(entity)
				1:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))

func getUnitFromTeamAt(team:int, pos:Vector2i)->Entity:
	var list:Node2D
	match team:
		0:list = team0
		1:list = team1
	for i in list.get_children():
		if i.tilePos == pos: return i
	var rep:Entity = null
	return rep

func getUnitAt(pos:Vector2i)->Entity:
	var allStar:Array
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())
	for i in allStar:
		if i.tilePos == pos: return i
	var rep:Entity = null
	return rep
	
