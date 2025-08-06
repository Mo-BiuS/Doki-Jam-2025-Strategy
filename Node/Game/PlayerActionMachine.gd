class_name PlayerActionMachine extends Node

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var gameUI:GameUI

@export var cursor:SelectCursor
@export var movementArea:MovementArea
@export var movementArrow:MovementArrow

var selectedEnity:Entity = null
var selectedBase:Base = null

func _process(_delta: float) -> void:
	processInput()

func processInput():
	if(cursor.ennemyList.is_empty() && selectedBase == null && !cursor.isMoving() && Input.is_action_just_pressed("action")):
		var entity:Entity = entityHandler.getUnitFromTeamAt(VarGame.teamTurn,cursor.tilePos)
		var base:Base = buildingHandler.getBaseFromTeamAt(VarGame.teamTurn,cursor.tilePos)
		if(selectedEnity == null && entity != null && selectedBase == null):
			selectedEnity = entity
			movementArrow.selectedEntity = entity
			movementArea.selectedEntity = entity
			movementArea.refresh()
		elif(selectedEnity != null && movementArea.get_cell_tile_data(cursor.tilePos) != null):
			selectedEnity.isMoving = true
			cursor.entityFollow = selectedEnity
			movementArrow.selectedEntity = null
			movementArea.selectedEntity = null
			movementArea.clear()
			movementArrow.clear()
			cursor.disable()
		elif(base != null):
			reset()
			selectedBase = base
			cursor.disable()
			gameUI.showBuildMenu()
		else:
			reset()
			
	
	elif(Input.is_action_just_pressed("return")):
		reset()

func reset():
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

func _on_select_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
	if(selectedEnity != null):movementArrow.refresh()


func _on_select_cursor_following_entity_ended_movement() -> void:
	var ennemyList:Array
	for i in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
		var entity:Entity = entityHandler.getUnitAt(cursor.tilePos+i)
		if(entity != null && entity.team != VarGame.teamTurn):
			ennemyList.append([entity,i])
	if(ennemyList.is_empty()):reset()
	else:cursor.setEnnemyList(ennemyList)


func _on_select_cursor_attack_at(tpos: Vector2i) -> void:
	var entity:Entity = entityHandler.getUnitAt(tpos)
	if(entity != null && entity.team != VarGame.teamTurn):
		selectedEnity.damage(entity, arenaHandler.arena.getDefenceAt(tpos),arenaHandler.arena.getDefenceAt(selectedEnity.tilePos))
	reset()
