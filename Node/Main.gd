class_name Main extends Node2D

var gamePacked:PackedScene

func _ready() -> void:
	gamePacked = preload("res://Node/Game/Game.tscn")

func _on_small_map_pressed() -> void:
	for i in get_children(): i.queue_free()
	var game:Game = gamePacked.instantiate()
	game.loadArena = preload("res://Node/Arena/LevelTest.tscn")
	add_child(game)
func _on_big_map_pressed() -> void:
	for i in get_children(): i.queue_free()
	var game:Game = gamePacked.instantiate()
	game.loadArena = preload("res://Node/Arena/StandardTestArena.tscn")
	add_child(game)
func _on_montain_test_pressed() -> void:
	for i in get_children(): i.queue_free()
	var game:Game = gamePacked.instantiate()
	game.loadArena = preload("res://Node/Arena/MontainTest.tscn")
	add_child(game)
