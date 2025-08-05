class_name Entity extends Node2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite

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

func _ready() -> void:
	sprite.play(str(team)+"-MovingSouth")

func setPosition(pos:Vector2i):
	tilePos = pos
	position = (Vector2(pos)*32+Vector2(16,16))*scale
