extends Node

var array:Array = [
	#					MVM	VISION	ATTACK	DEFENCE	COST
	["Dragoon Egg",		6,	2,		6,		0,		100],
	["Dragoon Chick",	6,	4,		6,		2,		200],
	["Dragoon Long",		8,	8,		6,		2,		300],
	["Dragoon Beeg",		4,	2,		10,		4,		400]
]

var packed = [
	preload("res://Node/Entity/DragoonEgg.tscn"),
	preload("res://Node/Entity/DragoonChick.tscn"),
	preload("res://Node/Entity/DragoonLong.tscn"),
	preload("res://Node/Entity/DragoonBeeg.tscn")
]
