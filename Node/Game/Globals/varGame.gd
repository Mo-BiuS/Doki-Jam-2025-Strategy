extends Node

var turn = 1;
var gold = [800,800];
var goldNext = [0,0]
var totalGoldUsed = [0,0]

var player = ["player","IA"]
var teamTurn = 0;
var winner = -1
#var player = ["IA","IA"]
#var teamTurn = -1;

var unitProduced = [
	[0,0,0,0],
	[0,0,0,0]
]

func reset():
	turn = 1;
	gold = [800,800];
	goldNext = [0,0]
	totalGoldUsed = [0,0]
	player = ["player","IA"]
	teamTurn = 0;
	winner = -1
	unitProduced = [[0,0,0,0],[0,0,0,0]]
