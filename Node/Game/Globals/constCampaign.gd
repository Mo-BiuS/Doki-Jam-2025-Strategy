extends Node

const INTRO = 0
const OUTRO = 1

const EFFECT_NONE = 0
const EFFECT_GREY = 1

const SPRITE_DOKI = preload("res://Ressources/Sprite/Char/Doki.png")
const SPRITE_TRICKSTER = preload("res://Ressources/Sprite/Char/Bouffon.png")
const SPRITE_DRAGOON_CHICK_ALLIED = preload("res://Ressources/Sprite/Unit/Icon/Icon-A-CHICK.png")
const SPRITE_DRAGOON_CHICK_ENNEMY = preload("res://Ressources/Sprite/Unit/Icon/Icon-B-CHICK.png")
const SPRITE_DRAGOON_EGG_ALLIED = preload("res://Ressources/Sprite/Unit/Icon/Icon-A-EGG.png")
const SPRITE_DRAGOON_EGG_ENNEMY = preload("res://Ressources/Sprite/Unit/Icon/Icon-B-EGG.png")

var isInCampaign:bool = false
var campaignNumber:int = -1
var nMission:int = 4

const arena:Array = [
	preload("res://Node/Arena/Campaign/Campaign1.tscn"),
	preload("res://Node/Arena/Campaign/Campaign2.tscn"),
	preload("res://Node/Arena/Campaign/Campaign3.tscn"),
	preload("res://Node/Arena/Campaign/Campaign4.tscn"),
]
const campaignName:Array = [
	"A rude awakening",
	"Comeback",
	"Ambush",
	"Last stand"
]

var dialogPointer:int
const campaignDialog:Array = [
	#MISSION 0
	[
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"What the hell is happening?"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"There she is! The fake Doki!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE],
			"She's the trickster!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"Get her!"],
		[OUTRO,[null,EFFECT_NONE,null,EFFECT_NONE],
			"Alright, done!"]
	],
	#MISSION 1
	[],
	#MISSION 2
	[],
	#MISSION 3
	[]
]

func hasIntroLeft()->bool:
	if(dialogPointer < campaignDialog[campaignNumber].size()):
		if(campaignDialog[campaignNumber][dialogPointer][0] == INTRO):return true
		else:return false
	else:return false 


func hasOutroLeft()->bool:
	return dialogPointer < campaignDialog[campaignNumber].size()


func getNextDialog()->Array:
	var rep:Array = campaignDialog[campaignNumber][dialogPointer]
	dialogPointer+=1
	return rep
	
