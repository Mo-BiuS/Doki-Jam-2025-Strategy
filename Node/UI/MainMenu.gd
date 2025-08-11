class_name MainMenu extends CanvasLayer

signal goCampagn
signal goTutorial
signal goSkirmish

@export var eggUp:AnimatedSprite2D
@export var chickUp:AnimatedSprite2D
@export var longUp:AnimatedSprite2D
@export var beegUp:AnimatedSprite2D

@export var eggDown:AnimatedSprite2D
@export var chickDown:AnimatedSprite2D
@export var longDown:AnimatedSprite2D
@export var beegDown:AnimatedSprite2D


func _ready() -> void:
	eggUp.play("0-MovingEast")
	chickUp.play("0-MovingEast")
	longUp.play("0-MovingEast")
	beegUp.play("0-MovingEast")
	
	eggDown.play("1-MovingWest")
	chickDown.play("1-MovingWest")
	longDown.play("1-MovingWest")
	beegDown.play("1-MovingWest")

func _on_campagn_mode_pressed() -> void:
	goCampagn.emit()
func _on_tutorial_mode_pressed() -> void:
	goTutorial.emit()
func _on_skirmish_mod_pressed() -> void:
	goSkirmish.emit()
