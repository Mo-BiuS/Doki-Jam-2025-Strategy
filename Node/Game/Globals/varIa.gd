extends Node

var priorityNeutralBuilding = [2,4]
var priorityEnnemyBuilding = [1,2]

var priorityBuildingTypeCapital = [3,4]
var priorityBuildingTypeBase = [2,3]
var priorityBuildingTypeCity = [0,1]

var captureReluctanceEgg = [0,0]
var captureReluctanceChick = [-2,-1]
var captureReluctanceLong = [0,0]
var captureReluctanceBeeg = [-4,-2]

var attackReluctanceArray = [
	[[2,2]	,[0,0]	,[0,0]	,[-2,-2]],#EGG
	[[2,2]	,[1,1]	,[1,1]	,[-2,-2]],#CHICK
	[[2,2]	,[1,1]	,[1,1]	,[-2,-2]],#LONG
	[[4,4]	,[2,2]	,[2,2]	,[1,1]],#BEEG
]
