class_name IaActionMachine extends Node

@export var game:Game

var isPlaying:bool = false

func start():
	isPlaying = true
func end():
	isPlaying = false

func _process(delta: float) -> void:
	if(isPlaying):
		game.endTurn()
