class_name SelectCursor extends Sprite2D

@export var arenaHandler:ArenaHandler

@onready var camera:Camera2D = $Camera

const SPEED = 400
var tilePos:Vector2i
var targetPos:Vector2
var enabled:bool = true

signal movedToNewTile(tPos:Vector2i)

func setTile(pos:Vector2i):
	if(pos != Vector2i(-1,-1) && arenaHandler.arena.isIn(pos)):
		tilePos = pos
		position = Vector2(tilePos*32+Vector2i(16,16))*scale
		targetPos = position
		movedToNewTile.emit(tilePos)

func _process(delta: float) -> void:
	if enabled:
		if targetPos == position:
			var direction:Vector2i = Vector2i.ZERO
			if Input.is_action_pressed("north"):	direction.y-=1
			if Input.is_action_pressed("east"):	direction.x+=1
			if Input.is_action_pressed("south"):	direction.y+=1
			if Input.is_action_pressed("west"):	direction.x-=1
			
			if direction != Vector2i.ZERO && arenaHandler.arena.isIn(tilePos + direction):
				targetPos = (Vector2(tilePos + direction) * 32 + Vector2(16, 16)) * scale
		
		else:
			position = position.move_toward(targetPos, SPEED * delta)
			if position == targetPos:
				tilePos = Vector2i(position / (32 * scale))
				movedToNewTile.emit(tilePos)

func isMoving()->bool:
	return targetPos != position

func disable()->void:
	enabled = false
	camera.enabled = false
func enable()->void:
	enabled = true
	camera.enabled = true
