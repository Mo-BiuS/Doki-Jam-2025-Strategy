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

var bgmMusic = [
	[-12,AudioStreamMP3.load_from_file("res://Ressources/Music/OFF THE ROAD - Zarii.mp3")],
	[0,AudioStreamMP3.load_from_file("res://Ressources/Music/Ancient Trials - Mark Hutson.mp3")]
	]
