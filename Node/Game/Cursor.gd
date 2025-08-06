class_name SelectCursor extends Sprite2D

var cursorTexture:Texture2D = load("res://Ressources/Sprite/UI/Cursor.png")
var attackTexture:Texture2D = load("res://Ressources/Sprite/UI/EnnemyAttackArea.png")

@export var arenaHandler:ArenaHandler

@onready var camera:Camera2D = $Camera

signal followingEntityEndedMovement

const SPEED = 400
var tilePos:Vector2i
var targetPos:Vector2
var enabled:bool = true
var entityFollow:Entity = null
var ennemyList:Array

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
	texture = attackTexture
	position = ennemyList[0][0].position
	tilePos = ennemyList[0][0].tilePos
	enable()
	
func clearEnnemyList():
	ennemyList.clear()
	texture = cursorTexture
	

func _process(delta: float) -> void:
	if(!ennemyList.is_empty()):
		if(Input.is_action_just_pressed("action")):
			attackAt.emit(tilePos)
		else:
			var dirList:Array
			if Input.is_action_pressed("north"):dirList.append(Vector2i(0,-1))
			elif Input.is_action_pressed("east"):	dirList.append(Vector2i(1,0))
			elif Input.is_action_pressed("south"):dirList.append(Vector2i(0,1))
			elif Input.is_action_pressed("west"):dirList.append(Vector2i(-1,0))
			if(!dirList.is_empty()):
				var fList:Array
				for i in ennemyList:
					if(dirList.has(i[1])):fList.append(i)
				if(!fList.is_empty()):
					var entity:Entity = fList[0][0]
					position = entity.position
					tilePos = entity.tilePos
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
