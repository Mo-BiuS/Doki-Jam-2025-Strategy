class_name IaActionMachine extends Node

@export var game:Game
@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var cursor:SelectCursor

const BREAK_TIME = 1.2
var breakTimer:float = BREAK_TIME
var isPlaying:bool = false

var entityList:Array[Entity]
var baseList:Array[Base]

#==================================================================
func start():
	isPlaying = true
func end():
	isPlaying = false
#==================================================================
func initTurn():
	entityList = entityHandler.getAllFromPlayingTeam()
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
	if(!entityList.is_empty()):
		var entity:Entity = entityList[0]
		cursor.setTile(entity.tilePos)
		
		entity.desactivate()
		entityList.erase(entity)
			
		return true
	else:return false
func base()->bool:
	while (!baseList.is_empty() && entityHandler.getUnitAt(baseList[0].tilePos) != null):baseList.erase(baseList[0])
	if(baseList.is_empty() || VarGame.gold[VarGame.teamTurn] < CONST_UNIT.lowestCost()):return false
	else:
		var base:Base = baseList[0]
		cursor.setTile(base.tilePos)
		var weightedTeam = entityHandler.getWeightedTeam()
		if(VarGame.turn < 2):weightedTeam[3] = 100.0
		
		var simpleLowest = 0
		var simpleLowestValue = weightedTeam[0]
		
		for i in range(1,weightedTeam.size()):
			if(weightedTeam[i] < simpleLowestValue):
				simpleLowest = i
				simpleLowestValue = weightedTeam[i]
		if(VarGame.gold[VarGame.teamTurn] >= CONST_UNIT.array[simpleLowest][5]):
			entityHandler._on_game_ui_buy_unit(simpleLowest)
			baseList.erase(base)
			return true
		else:weightedTeam.remove_at(simpleLowest)
		
		baseList.clear()
		return true
