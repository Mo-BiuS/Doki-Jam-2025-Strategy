class_name IaActionMachine extends Node

@export var game:Game
@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var cursor:SelectCursor

const BREAK_TIME = 1.2
var breakTimer:float = BREAK_TIME
var isPlaying:bool = false

var unitList:Array[Entity]
var baseList:Array[Base]

#==================================================================
func start():
	isPlaying = true
func end():
	isPlaying = false
#==================================================================
func initTurn():
	unitList = entityHandler.getAllFromPlayingTeam()
	baseList = buildingHandler.getAllBaseFromPlayingTeam()

func _process(delta: float) -> void:
	if(isPlaying):
		if(breakTimer > 0):breakTimer-=delta
		else:
			breakTimer = BREAK_TIME
			if(unit()):pass
			elif(base()):pass
			else:game.endTurn()
#==================================================================
func unit()->bool:
	if(!unitList.is_empty()):
		#TODO
		return false
	else:return false
func base()->bool:
	if(!baseList.is_empty()):
		#TODO
		return false
	else:return false
