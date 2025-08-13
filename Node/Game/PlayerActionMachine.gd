class_name PlayerActionMachine extends Node

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var gameUI:GameUI

@export var cursor:SelectCursor
@export var movementArea:MovementArea
@export var movementArrow:MovementArrow

var escapeMenuOpened:bool = false
var selectedEnity:Entity = null
var selectedBase:Base = null
var isPlaying:bool = true


func _process(_delta: float) -> void:
	if(isPlaying):processInput()

func processInput():
	if(!escapeMenuOpened):
		if(cursor.ennemyList.is_empty() && selectedBase == null && !cursor.isMoving() && Input.is_action_just_pressed("action")):
			var entity:Entity = entityHandler.getUnitFromTeamAt(VarGame.teamTurn,cursor.tilePos)
			var base:Base = buildingHandler.getBaseFromTeamAt(VarGame.teamTurn,cursor.tilePos)
			if(selectedEnity == null && entity != null && selectedBase == null && entity.isActivated):
				selectedEnity = entity
				movementArrow.selectedEntity = entity
				movementArea.selectedEntity = entity
				movementArea.refresh()
			elif(selectedEnity != null && (movementArrow.get_cell_tile_data(cursor.tilePos) != null || selectedEnity.tilePos == cursor.tilePos)):
				selectedEnity.isMoving = true
				cursor.entityFollow = selectedEnity
				movementArrow.selectedEntity = null
				movementArea.selectedEntity = null
				movementArea.clear()
				movementArrow.clear()
				cursor.disable()
			elif(entityHandler.getUnitAt(cursor.tilePos) == null && base != null && entity == null):
				reset()
				selectedBase = base
				cursor.disable()
				gameUI.showBuildMenu()
			else:
				reset()
				
		elif(Input.is_action_just_pressed("return")):
			if(selectedEnity == null && selectedBase == null):
				escapeMenuOpened = true
				cursor.disable()
				gameUI.showEscapeMenu()
			elif(selectedEnity != null && selectedEnity.hasMoved):
				selectedEnity.desactivate()
				reset()
			else:
				reset()
	elif (Input.is_action_just_pressed("return")):
		if(escapeMenuOpened):
			escapeMenuOpened = false
			cursor.enable()
			gameUI.hideEscapeMenu()

func reset():
	escapeMenuOpened = false
	selectedEnity = null
	selectedBase = null
	movementArrow.selectedEntity = null
	movementArea.selectedEntity = null
	movementArea.clear()
	movementArrow.clear()
	cursor.clearEnnemyList()
	cursor.entityFollow = null
	cursor.enable()
	gameUI.hideBuildMenu()
	gameUI._on_cursor_moved_to_new_tile(cursor.tilePos)

func _on_select_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
	if(selectedEnity != null):movementArrow.refresh()


func _on_select_cursor_following_entity_ended_movement() -> void:
	var empty = true
	var ennemyList:Array
	for i in [Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0)]:
		var entity:Entity = entityHandler.getUnitAt(cursor.tilePos+i)
		if(entity != null && entity.team != VarGame.teamTurn):
			ennemyList.append(entity)
			empty = false
		else:
			ennemyList.append(null)
	var building:Building = buildingHandler.getBuildingAtPos(cursor.tilePos)
	if(building != null && building.team != VarGame.teamTurn+1):
		ennemyList.append(building)
		empty = false
	else:
		ennemyList.append(null)
	
	if(empty):
		selectedEnity.desactivate()
		reset()
	else:cursor.setEnnemyList(ennemyList)


func _on_select_cursor_attack_at(tpos: Vector2i) -> void:
	var entity:Entity = entityHandler.getUnitAt(tpos)
	if(entity != null && entity.team != VarGame.teamTurn):
		selectedEnity.damage(entity, arenaHandler.arena.getDefenceAt(tpos),arenaHandler.arena.getDefenceAt(selectedEnity.tilePos))
	else:
		var building:Building = buildingHandler.getBuildingAtPos(tpos)
		if(building != null && building.team != VarGame.teamTurn+1):
			selectedEnity.capture(building)
			VarGame.goldNext[VarGame.teamTurn] = buildingHandler.getGoldFromPlayer(VarGame.teamTurn)
			gameUI.refreshRessourcePanel()
		
	reset()
