class_name RessourcePanel extends PanelContainer

@export var dokiGoldLabel:Label
@export var trickGoldLabel:Label
@export var turnLabel:Label

func _ready() -> void:
	refresh()

func refresh() -> void:
	dokiGoldLabel.text = "Dokibird gold  : " + str(VarGame.gold[0]) + " (+"+str(VarGame.goldNext[0])+")"
	trickGoldLabel.text = "Trickster gold : " + str(VarGame.gold[1]) + " (+"+str(VarGame.goldNext[1])+")"
	turnLabel.text = "Turn : " + str(VarGame.turn)
