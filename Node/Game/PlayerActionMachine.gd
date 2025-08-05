extends Node

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var cursor:SelectCursor
@export var movementArea:MovementArea
@export var movementArrow:MovementArrow

var teamTurn = 0;
var selectedEnity:Entity = null

func _process(_delta: float) -> void:
	processInput()

func processInput():
	if(!cursor.isMoving() && Input.is_action_just_pressed("action")):
		var entity:Entity = entityHandler.getUnitFromTeamAt(teamTurn,cursor.tilePos)
		if(entity != null):
			selectedEnity = entity
			movementArrow.selectedEntity = entity
			movementArea.selectedEntity = entity
			movementArea.refresh()
		elif(selectedEnity != null && movementArea.get_cell_tile_data(cursor.tilePos) != null):
			print("DEPLACEMENT")
		else:
			selectedEnity = null
			movementArrow.selectedEntity = null
			movementArea.selectedEntity = null
			movementArea.clear()
			movementArrow.clear()
			
	
	if(Input.is_action_just_pressed("return")):
		selectedEnity = null
		movementArrow.selectedEntity = null
		movementArea.selectedEntity = null
		movementArea.clear()
		movementArrow.clear()


func _on_select_cursor_moved_to_new_tile(tPos: Vector2i) -> void:
	if(selectedEnity != null):movementArrow.refresh()
