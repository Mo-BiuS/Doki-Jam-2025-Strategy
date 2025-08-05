class_name RessourcePanel extends PanelContainer

@export var goldLabel:Label

func _ready() -> void:
	refresh()

func refresh() -> void:
	goldLabel.text = "Gold : " + str(VarGame.gold)
