class_name Entity extends Node2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite

var team:int = -1
var life:int = 10
var veterancy:int = 0

var speed:int	= 0
var vision:int	= 0
var attack:int	= 0
var defence:int	= 0
var cost:int		= 0

func _ready() -> void:
	sprite.play(str(team)+"-MovingSouth")
	
