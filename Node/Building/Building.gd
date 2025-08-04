class_name Building extends Node2D

@onready var sprite:AnimatedSprite2D = $Sprite
var team = -1
var tilePos:Vector2i

func _ready() -> void:
	match team:
		0:sprite.play("N")
		1:sprite.play("A")
		2:sprite.play("B")
		_:print("error invalid team")
		
func setPosition(pos:Vector2i):
	tilePos = pos
	position = (Vector2(pos)*32+Vector2(16,16))*scale
