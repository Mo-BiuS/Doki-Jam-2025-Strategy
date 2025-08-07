class_name SelectCursor extends Sprite2D

var cursorTexture:Texture2D = load("res://Ressources/Sprite/UI/Cursor.png")
var attackTexture:Texture2D = load("res://Ressources/Sprite/UI/EnnemyAttackArea.png")
var captureTexture:Texture2D = load("res://Ressources/Sprite/UI/CaptureArea.png")

@export var arenaHandler:ArenaHandler

@onready var camera:Camera2D = $Camera

signal followingEntityEndedMovement

const SPEED = 400
var tilePos:Vector2i
var targetPos:Vector2
var enabled:bool = true
var entityFollow:Entity = null
var ennemyList:Array
var ennemyListPos:int = -1

signal movedToNewTile(tPos:Vector2i)
signal attackAt(tpos:Vector2i)

func setTile(pos:Vector2i):
	if(pos != Vector2i(-1,-1) && arenaHandler.arena.isIn(pos)):
		tilePos = pos
		position = Vector2(tilePos*32+Vector2i(16,16))*scale
		targetPos = position
		movedToNewTile.emit(tilePos)

func _ready() -> void:
	texture = cursorTexture

func setEnnemyList(eList:Array):
	ennemyList = eList
	var entity
	for i in ennemyList.size():
		if ennemyList[i] != null:
			entity = ennemyList[i]
			ennemyListPos = 1
			break
	if(ennemyList[4] == entity):texture = captureTexture
	else:texture = attackTexture
	position = entity.position
	tilePos = entity.tilePos
	enable()
	
func clearEnnemyList():
	ennemyList.clear()
	texture = cursorTexture
	

func _process(delta: float) -> void:
	if(!ennemyList.is_empty()):
		if(Input.is_action_just_pressed("action")):
			attackAt.emit(tilePos)
		else:
			var direction: Vector2i = Vector2i.ZERO
			if Input.is_action_just_pressed("north"): direction.y -= 1
			if Input.is_action_just_pressed("east"):  direction.x += 1
			if Input.is_action_just_pressed("south"): direction.y += 1
			if Input.is_action_just_pressed("west"):  direction.x -= 1

			var dir_to_index := {
				Vector2i(0, -1): 0,  # nord
				Vector2i(1, 0):  1,  # est
				Vector2i(0, 1):  2,  # sud
				Vector2i(-1, 0): 3   # ouest
			}

			if direction != Vector2i.ZERO && dir_to_index.has(direction):
				var target_index = dir_to_index[direction]
				if ennemyListPos == 4:
					if ennemyList[target_index] != null:
						ennemyListPos = target_index
						position = ennemyList[target_index].position
						tilePos = ennemyList[target_index].tilePos
				elif ennemyListPos in [0, 1, 2, 3]:
					if ennemyList[4] != null:
						ennemyListPos = 4
						position = ennemyList[4].position
						tilePos = ennemyList[4].tilePos
					elif ennemyList[target_index] != null:
						ennemyListPos = target_index
						position = ennemyList[target_index].position
						tilePos = ennemyList[target_index].tilePos
				if(ennemyListPos == 4):texture = captureTexture
				else:texture = attackTexture
	
	elif entityFollow != null:
		position = entityFollow.position
		if(!entityFollow.isMoving):
			followingEntityEndedMovement.emit()
	elif enabled:
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
	#camera.enabled = false
	hide()
func enable()->void:
	enabled = true
	#camera.enabled = true
	show()
