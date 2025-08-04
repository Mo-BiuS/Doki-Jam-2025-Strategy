extends Node

const STATE_UNSELECTED = 0
const STATE_UNIT_SELECTED = 10
var state = STATE_UNSELECTED

@export var arenaHandler:ArenaHandler
@export var buildingHandler:BuildingHandler
@export var entityHandler:EntityHandler

@export var cursor:SelectCursor
@export var movementArea:MovementArea

var teamTurn = 0;
var selectedEnity:Entity = null

func _process(delta: float) -> void:
	match state:
		STATE_UNSELECTED:processInput()
		STATE_UNIT_SELECTED:movingEntity()
		_:print(state, " is not a state")

func processInput():
	if(!cursor.isMoving() && Input.is_action_just_pressed("action")):
		var entity:Entity = entityHandler.getUnitFromTeamAt(teamTurn,cursor.tilePos)
		if(entity != null):
			movementArea.selectedEntity = entity
			movementArea.refresh()
			selectedEnity = entity
			state = STATE_UNIT_SELECTED
	
func movingEntity():
	if(Input.is_action_just_pressed("return")):
		movementArea.clear()
		state = STATE_UNSELECTED
		
