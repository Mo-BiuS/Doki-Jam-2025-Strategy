class_name Main extends Node2D


var mainMenuPacked:PackedScene = preload("res://Node/UI/MainMenu.tscn")
var skirmishMenuPacked:PackedScene = preload("res://Node/UI/SkirmishMenu.tscn")
var gamePacked:PackedScene = preload("res://Node/Game/Game.tscn")

func _ready() -> void:
	loadMainMenu()

func loadMainMenu()->void:
	for i in get_children():i.queue_free()
	var mainMenu:MainMenu = mainMenuPacked.instantiate()
	mainMenu.goCampagn
	mainMenu.goTutorial
	mainMenu.goSkirmish.connect(loadSkirmishMenu)
	add_child(mainMenu)
func loadSkirmishMenu()->void:
	for i in get_children():i.queue_free()
	var skirmishMenu:SkirmishMenu = skirmishMenuPacked.instantiate()
	skirmishMenu.toMainMenu.connect(loadMainMenu)
	skirmishMenu.toGame.connect(loadGame)
	add_child(skirmishMenu)
func loadGame(arena:PackedScene)->void:
	for i in get_children():i.queue_free()
	var game:Game = gamePacked.instantiate()
	game.loadArena = arena
	add_child(game)
