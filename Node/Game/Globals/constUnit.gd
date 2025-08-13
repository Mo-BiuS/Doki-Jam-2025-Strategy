extends Node

const UNIT_EGG = 0
const UNIT_CHICK = 1
const UNIT_LONG = 2
const UNIT_BEEG = 3

var array:Array = [
	#					MVM	VISION	ATTACK	DEFENCE	COST		WEIGHT
	["Dragoon Egg",		6,	2,		6,		0,		150,		2],
	["Dragoon Chick",	6,	4,		6,		2,		500,		6],
	["Dragoon Long",		10,	8,		6,		2,		900,		2],
	["Dragoon Chonk",	4,	2,		11,		4,		1400,	1]
]

var packed = [
	preload("res://Node/Entity/DragoonEgg.tscn"),
	preload("res://Node/Entity/DragoonChick.tscn"),
	preload("res://Node/Entity/DragoonLong.tscn"),
	preload("res://Node/Entity/DragoonBeeg.tscn")
]

func lowestCost()->int:
	var rep:int = array[0][5]
	for i in range(0,array.size()):
		if(array[i][5] < rep):rep = array[i][5]
	return rep
