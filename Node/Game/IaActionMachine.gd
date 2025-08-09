class_name IaActionMachine extends Node

const ACTION_ATTACK = 1
const ACTION_CAPTURE = 2
const ACTION_RUN_AWAY = 3

@export var game:Game
@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler
@export var cursor:SelectCursor

const BREAK_TIME = .8
var breakTimer:float = BREAK_TIME
var isPlaying:bool = false
var waiting:bool = false

var entityList:Array[Entity]
var baseList:Array[Base]

#==================================================================
func start():
	isPlaying = true
func end():
	isPlaying = false
#==================================================================
func initTurn():
	entityList = entityHandler.getAllFromPlayingTeamOrdered()
	baseList = buildingHandler.getAllBaseFromPlayingTeamOrdered()
	

func _process(delta: float) -> void:
	if(isPlaying):
		if(breakTimer > 0):breakTimer-=delta
		elif(!waiting):
			breakTimer = BREAK_TIME
			if(!unit() && !base()):game.endTurn()
#==================================================================
func unit()->bool:
	if(!entityList.is_empty()):
		var entity:Entity = entityList[0]
		arenaHandler.calculateAreaMap(entity)
		var priorityTarget = calculatePriority(entity)
		if(priorityTarget != null):
			if(priorityTarget is Entity):print("TODO")
			elif(priorityTarget is Building):entity.goCapture(priorityTarget)
			
			cursor.setTile(entity.tilePos)
			cursor.entityFollow = entity
			entityList.erase(entity)
			waiting = true
		else:
			cursor.setTile(entity.tilePos)
			entity.desactivate()
			entityList.erase(entity)
			
		return true
	else:
		cursor.entityFollow = null
		return false
func base()->bool:
	while (!baseList.is_empty() && entityHandler.getUnitAt(baseList[0].tilePos) != null):baseList.erase(baseList[0])
	if(baseList.is_empty() || VarGame.gold[VarGame.teamTurn] < CONST_UNIT.lowestCost()):return false
	else:
		var base:Base = baseList[0]
		cursor.setTile(base.tilePos)
		var weightedTeam = entityHandler.getWeightedTeam()
		if(VarGame.turn < 2):weightedTeam[CONST_UNIT.UNIT_BEEG] = 100.0
		
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

func calculatePriority(e:Entity):
	var rep = null
	var repScore = 16384
	var ennemyBuildingList:Array[Building] = buildingHandler.getAllFromEnnemyTeam()
	var ennemyEntityList:Array[Entity] = entityHandler.getAllFromEnnemyTeam()
	
	for i in ennemyEntityList:
		pass
	for i in ennemyBuildingList:
		if(i.tilePos == e.tilePos && i.capture != 10):return i
		elif(e.areaDict.has(i.tilePos)):
			var modif = 0;
			var range:Array
			if(i.team == 0):range=VarIa.priorityNeutralBuilding
			else:range=VarIa.priorityEnnemyBuilding
			modif+=randi_range(range[0],range[1])
			
			if(i is Capital):range=VarIa.priorityBuildingTypeCapital
			elif(i is Base):range=VarIa.priorityBuildingTypeBase
			elif(i is City):range=VarIa.priorityBuildingTypeCity
			modif+=randi_range(range[0],range[1])
			
			if(e is DragoonEgg):range=VarIa.captureReluctanceEgg
			elif(e is DragoonChick):range=VarIa.captureReluctanceChick
			elif(e is DragoonLong):range=VarIa.captureReluctanceLong
			elif(e is DragoonBeeg):range=VarIa.captureReluctanceBeeg
			
			if(e.areaDict[i.tilePos]-modif < repScore):
				rep = i
				repScore = e.areaDict[i.tilePos]-modif
	
	return rep
