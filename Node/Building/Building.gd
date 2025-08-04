class_name Building extends Node2D

@onready var sprite:AnimatedSprite2D = $Sprite
var team = -1

func _ready() -> void:
	match team:
		0:sprite.play("N")
		1:sprite.play("A")
		2:sprite.play("B")
		_:print("error invalid team")
