extends Node

const INTRO = 0
const OUTRO = 1

const EFFECT_NONE = 0
const EFFECT_GREY = 1

const SPRITE_DOKI = preload("res://Ressources/Sprite/Char/Doki.png")
const SPRITE_TRICKSTER = preload("res://Ressources/Sprite/Char/Bouffon.png")
const SPRITE_MALEVOLENT = preload("res://Ressources/Sprite/Char/Malevolent.png")
const SPRITE_DRAGOON_CHICK_ALLIED = preload("res://Ressources/Sprite/Unit/Icon/Icon-A-CHICK.png")
const SPRITE_DRAGOON_CHICK_ENNEMY = preload("res://Ressources/Sprite/Unit/Icon/Icon-B-CHICK.png")
const SPRITE_DRAGOON_EGG_ALLIED = preload("res://Ressources/Sprite/Unit/Icon/Icon-A-EGG.png")
const SPRITE_DRAGOON_EGG_ENNEMY = preload("res://Ressources/Sprite/Unit/Icon/Icon-B-EGG.png")

var isInCampaign:bool = false
var campaignNumber:int = -1
var nMission:int = 5

const arena:Array = [
	preload("res://Node/Arena/Campaign/Campaign1.tscn"),
	preload("res://Node/Arena/Campaign/Campaign2.tscn"),
	preload("res://Node/Arena/Campaign/Campaign3.tscn"),
	preload("res://Node/Arena/Campaign/Campaign4.tscn"),
	preload("res://Node/Arena/Campaign/Campaign5.tscn"),
]
const campaignName:Array = [
	"A rude awakening",
	"Comeback",
	"Ambush",
	"Last stand",
	"The malevolent one"
]

var dialogPointer:int
const campaignDialog:Array = [
	#MISSION 0
	[
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Well that's new..."],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"There she is! The fake Doki!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE],
			"She's the trickster!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"Get her!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"No, she is the real one!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"What should we do..."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"Well if it's a fight you want!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE],
			"Hummm... there is no Base on this map."],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE],
			"We should use the Cities we captured to regain force and push forward."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_GREY],
			"Alright, I got this!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Alright, done! You guys are no match for me and my loyal Dragoons!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"My head... Wait... This is the real Doki!"],
		[OUTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"It seems that getting beaten up knocked some sense into them."],
		[OUTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"And why am I purple?"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"Alright, everyone pack up! Let's find that impostor!"],
		[OUTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"YEAH!"]
	],
	#MISSION 1
	[
		[INTRO,[null,EFFECT_NONE,null,EFFECT_NONE],
			"Hon hon hon..."],
		[INTRO,[null,EFFECT_NONE,null,EFFECT_NONE],
			"Don't let this impostor cross the bridge, my little Dragoons."],
		[INTRO,[SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE],
			"Yes Ma'm!"],
		[OUTRO,[null,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"Owwww... My head... Where am I?"],
		[OUTRO,[null,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"Doki???"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_GREY],
			"Alright, where is the impostor?"],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE],
			"Ho I know! I remember! Follow me!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_GREY],
			"Let's go!"]
	],
	#MISSION 2
	[
		[INTRO,[null,EFFECT_NONE,null,EFFECT_NONE],
			"Hon hon hon!"],
		[INTRO,[null,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_NONE],
			"Welcome to my trap! IMPOSTOR!"],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_GREY],
			"Seriously?"],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_GREY],
			"He's just a clown with a mask!"],
		[INTRO,[SPRITE_DRAGOON_EGG_ALLIED,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_GREY],
			"Well, I think it was pretty convincing before, but now..."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_GREY],
			"How can anyone fall for this?"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_TRICKSTER,EFFECT_NONE],
			"Hey! I'm still here! Pay attention to me!"],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_TRICKSTER,EFFECT_NONE],
			"I've got the troops and I'm in a very good position!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_GREY],
			"Wait... We are surrounded!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_GREY,SPRITE_TRICKSTER,EFFECT_NONE],
			"Eeeeexactly! Dragoons, get her!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE,SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE],
			"Yes Ma'm!"],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Alright, let's get that clown!"],
		[OUTRO,[null,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_NONE],
			"Bravo, bravo! But it's just a minor setback!"],
		[OUTRO,[null,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_NONE],
			"You won't be able to win next time!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Hey come back here, you stupid harlequin!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"I'm gonna take those last dragoons back!"]
	],
	#MISSION 3
	[
		[INTRO,[null,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_NONE],
			"Here we are! Our last Bastion!"],
		[INTRO,[null,EFFECT_NONE,SPRITE_TRICKSTER,EFFECT_NONE],
			"En avant, Dragoons!"],
		[INTRO,[SPRITE_DRAGOON_EGG_ENNEMY,EFFECT_NONE,SPRITE_DRAGOON_CHICK_ENNEMY,EFFECT_NONE],
			"Yes Ma'm!"],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Well, it looks like he got nowhere to run."],
		[INTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE],
			"And those are his last troops! Let's finish this!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_NONE],
			"Where is that stupid guy?"],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE],
			"Impossible to find him..."],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_DRAGOON_EGG_ALLIED,EFFECT_NONE],
			"Wait what is that noise?"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_DRAGOON_EGG_ALLIED,EFFECT_GREY],
			"Huh?"],
	],
	#MISSION 4
	[
		[INTRO,[null,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_NONE],
			"MUHAHAHAHAHA! I KNOW THAT THE LORD OF THOSE LANDS ARE TOTALLY UNPREPARED"],
		[INTRO,[null,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_NONE],
			"I AM A SPIRIT OF WAR! A DEMON OF CONQUEST!"],
		[INTRO,[null,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_NONE],
			"IT WILL BE A PIECE OF CAKE TO CONQUER THEM..."],
		[INTRO,[null,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_NONE],
			"WAIT..."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_GREY],
			"Welp... Bad timing for you, I guess."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_GREY],
			"Dragoons!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_EGG_ALLIED,EFFECT_NONE],
			"..."],
		[INTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_GREY],
			"Beat up that loser!"],
		[INTRO,[SPRITE_DRAGOON_CHICK_ALLIED,EFFECT_NONE,SPRITE_DRAGOON_EGG_ALLIED,EFFECT_NONE],
			"YEAH!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_MALEVOLENT,EFFECT_NONE],
			"IT'S UNFAIR! YOU WERE SUPOSED TO BE DEFENCELESS AND UNPREPARED!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,SPRITE_MALEVOLENT,EFFECT_GREY],
			"Well, tough luck for you. Now bye!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_GREY,SPRITE_MALEVOLENT,EFFECT_NONE],
			"I WILL BE BACK..."],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_GREY],
			"What a day!"],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_GREY],
			"Wonder where that stupid jester went."],
		[OUTRO,[SPRITE_DOKI,EFFECT_NONE,null,EFFECT_GREY],
			"Ho well..."],
		
	]
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
	
