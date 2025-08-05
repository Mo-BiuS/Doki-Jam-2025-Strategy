class_name Entity extends Node2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite

const SPEED = 400

var tilePos:Vector2i

var team:int = -1
var life:int = 10
var veterancy:int = 0

var mvm:int	= 0
var vision:int	= 0
var attack:int	= 0
var defence:int	= 0
var cost:int		= 0

var mvmMap:Array
var isMoving:bool = false

func _ready() -> void:
	sprite.play(str(team)+"-MovingSouth")

func _process(delta: float) -> void:
	if isMoving:
		var pos = mvmMap[mvmMap.size()-1]
		var targetPos:Vector2 = Vector2(pos)*64+Vector2(32,32)
		var newPosition:Vector2 = position.move_toward(targetPos, SPEED * delta)
		
		if(newPosition.x-position.x > 0):sprite.play(str(team)+"-MovingEast")
		if(newPosition.x-position.x < 0):sprite.play(str(team)+"-MovingWest")
		if(newPosition.y-position.y > 0):sprite.play(str(team)+"-MovingSouth")
		if(newPosition.y-position.y < 0):sprite.play(str(team)+"-MovingNordth")
		
		position = newPosition 
		
		if position == targetPos:
			tilePos = Vector2i(position / (32 * scale))
			mvmMap.erase(pos)
			if(mvmMap.is_empty()):isMoving=false

func setPosition(pos:Vector2i):
	tilePos = pos
	position = (Vector2(pos)*32+Vector2(16,16))*scale

func startMoving()->void:
	pass
