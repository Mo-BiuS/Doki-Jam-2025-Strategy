class_name BuildingHandler extends Node2D

const BUILDING_PACKED_CITY:PackedScene = preload("res://Node/Building/City.tscn")
const BUILDING_PACKED_BASE:PackedScene = preload("res://Node/Building/Base.tscn")
const BUILDING_PACKED_CAPITAL:PackedScene = preload("res://Node/Building/Capital.tscn")

@export var arenaHandler:ArenaHandler

@onready var neutral:Node2D = $Neutral
@onready var team0:Node2D = $Team0
@onready var team1:Node2D = $Team1

func reset() -> void:
	for i in neutral.get_children():i.queue_free()
	for i in team0.get_children():i.queue_free()
	for i in team1.get_children():i.queue_free()
	for team in range(3):
		loadStartingBuilding(team,arenaHandler.arena.getBuidingMap(team))
		
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
			entity.setPosition(Vector2i(i[1],i[2]))
			match team:
				0:neutral.add_child(entity)
				1:team0.add_child(entity)
				2:team1.add_child(entity)
				_:print("Loading starting entity, no team "+str(team))

func getCapitalPos(player:int)->Vector2i:
	var list:Node2D
	match player:
		0:list = team0
		1:list = team1
		_:print("get capital error player index")
	for i in list.get_children():
		if i is Capital:
			return i.position/64
	return Vector2i(-1,-1)

func getBaseFromTeamAt(team:int, pos:Vector2i)->Base:
	var list:Node2D
	match team:
		0:list = team0
		1:list = team1
	for i in list.get_children():
		if i is Base && i.tilePos == pos: return i
	return null

func getBuildingAtPos(pos:Vector2i) -> Building:
	var allStar:Array
	allStar.append_array(neutral.get_children())
	allStar.append_array(team0.get_children())
	allStar.append_array(team1.get_children())

	for b in allStar:
		if b.tilePos == pos : return b
	return null
