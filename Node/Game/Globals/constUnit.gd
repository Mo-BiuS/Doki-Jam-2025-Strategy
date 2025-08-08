extends Node

var array:Array = [
	#					MVM	VISION	ATTACK	DEFENCE	COST		WEIGHT
	["Dragoon Egg",		6,	2,		6,		0,		200,		2],
	["Dragoon Chick",	6,	4,		6,		2,		600,		4],
	["Dragoon Long",		8,	8,		6,		2,		800,		1],
	["Dragoon Beeg",		4,	2,		10,		4,		1200,	1]
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
