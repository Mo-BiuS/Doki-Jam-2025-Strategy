class_name Main extends Node2D


var mainMenuPacked:PackedScene = preload("res://Node/UI/MainMenu.tscn")
var campaignMenuPacked:PackedScene = preload("res://Node/UI/CampaignMenu.tscn")
var skirmishMenuPacked:PackedScene = preload("res://Node/UI/SkirmishMenu.tscn")
var gamePacked:PackedScene = preload("res://Node/Game/Game.tscn")
var endScreenPacked:PackedScene = preload("res://Node/UI/EndScreen.tscn")

func _ready() -> void:
	loadMainMenu()

func loadMainMenu()->void:
	for i in get_children():i.queue_free()
	var mainMenu:MainMenu = mainMenuPacked.instantiate()
	mainMenu.goCampagn.connect(loadCampaignMenu)
	mainMenu.goTutorial
	mainMenu.goSkirmish.connect(loadSkirmishMenu)
	add_child(mainMenu)
func loadCampaignMenu()->void:
	for i in get_children():i.queue_free()
	var campaignMenu:CampaignMenu = campaignMenuPacked.instantiate()
	campaignMenu.toMainMenu.connect(loadMainMenu)
	campaignMenu.toCampaign.connect(loadGame)
	add_child(campaignMenu)
	
func loadSkirmishMenu()->void:
	for i in get_children():i.queue_free()
	var skirmishMenu:SkirmishMenu = skirmishMenuPacked.instantiate()
	skirmishMenu.toMainMenu.connect(loadMainMenu)
	skirmishMenu.toGame.connect(loadGame)
	add_child(skirmishMenu)
func loadGame(arena:PackedScene, campaignNumber:int)->void:
	if(campaignNumber != -1):
		CONST_CAMPAIGN.campaignNumber = campaignNumber
		CONST_CAMPAIGN.isInCampaign = true
	else:
		CONST_CAMPAIGN.campaignNumber = -1
		CONST_CAMPAIGN.isInCampaign = false
		
	for i in get_children():i.queue_free()
	var game:Game = gamePacked.instantiate()
	game.loadArena = arena
	game.toMainMenu.connect(loadMainMenu)
	game.toNextMission.connect(nextMission)
	add_child(game)

func loadEndScreen():
	for i in get_children():i.queue_free()
	var endScreen:EndScreen = endScreenPacked.instantiate()
	endScreen.toMainMenu.connect(loadMainMenu)
	add_child(endScreen)

func nextMission():
	if(CONST_CAMPAIGN.nMission != CONST_CAMPAIGN.campaignNumber+1):
		loadGame(CONST_CAMPAIGN.arena[CONST_CAMPAIGN.campaignNumber+1],CONST_CAMPAIGN.campaignNumber+1)
	else:
		loadEndScreen()
