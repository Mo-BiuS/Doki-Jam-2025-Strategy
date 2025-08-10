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
			if(priorityTarget[0] is Entity):
				entity.goAttack(priorityTarget[0],priorityTarget[1])
			elif(priorityTarget[0] is Building):entity.goCapture(priorityTarget[0])
			
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
		var objectivePos = null
		var objectiveValue = 16384
		for dir in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
			if((entityHandler.getUnitAt(i.tilePos+dir) == null || entityHandler.getUnitAt(i.tilePos+dir) == e) && e.areaDict.has(i.tilePos+dir) && e.areaDict.get(i.tilePos+dir) < objectiveValue):
				objectiveValue = e.areaDict.get(i.tilePos+dir)
				objectivePos = i.tilePos+dir
			if(objectivePos != null):
				e.mvmMap.clear()
				e.trace(objectivePos)
				e.traceClean()
				if(!e.mvmMap.is_empty() || i.tilePos+dir == e.tilePos):
					var modif = 0;
					var range:Array = VarIa.attackReluctanceArray[e.typeId][i.typeId]
					modif+=randi_range(range[0],range[1])
					
					if(e.areaDict[objectivePos]-modif < repScore):
						rep = [i,objectivePos]
						repScore = e.areaDict[objectivePos]-modif
	for i in ennemyBuildingList:
		if(i.tilePos == e.tilePos && i.capture != 10):return [i,null]
		elif(entityHandler.getUnitAt(i.tilePos) == null && e.areaDict.has(i.tilePos)):
			e.mvmMap.clear()
			e.trace(i.tilePos)
			e.traceClean()
			if(!e.mvmMap.is_empty()):
				var modif = 0;
				var range:Array
				if(i.team == 0):range=VarIa.priorityNeutralBuilding
				else:range=VarIa.priorityEnnemyBuilding
				modif+=randi_range(range[0],range[1])
				
				if(i is Capital):range=VarIa.priorityBuildingTypeCapital
				elif(i is Base):range=VarIa.priorityBuildingTypeBase
				elif(i is City):range=VarIa.priorityBuildingTypeCity
				modif+=randi_range(range[0],range[1])
				
				modif+=(10-e.life)*2
				
				if(e is DragoonEgg):range=VarIa.captureReluctanceEgg
				elif(e is DragoonChick):range=VarIa.captureReluctanceChick
				elif(e is DragoonLong):range=VarIa.captureReluctanceLong
				elif(e is DragoonBeeg):range=VarIa.captureReluctanceBeeg
				
				if(e.areaDict[i.tilePos]-modif < repScore):
					rep = [i,null]
					repScore = e.areaDict[i.tilePos]-modif
	return rep
