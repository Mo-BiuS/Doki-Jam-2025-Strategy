class_name RessourcePanel extends PanelContainer

@export var goldLabel:Label
@export var turnLabel:Label

func _ready() -> void:
	refresh()

func refresh() -> void:
	goldLabel.text = "Gold : " + str(VarGame.gold[VarGame.teamTurn])
	turnLabel.text = "Turn : " + str(VarGame.turn)
