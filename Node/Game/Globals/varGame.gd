extends Node

var turn = 1;
var gold = [800,800];

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
	VarGame.turn = 1;
	VarGame.gold = [800,800];
	VarGame.player = ["player","IA"]
	VarGame.teamTurn = 0;
	VarGame.winner = -1
	VarGame.unitProduced = [[0,0,0,0],[0,0,0,0]]
