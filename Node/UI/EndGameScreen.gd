class_name EndGameScreen extends PanelContainer

@export var winnerLabel:Label

@export var dokiMoney:Label
@export var triksterMoney:Label

@export var DokibirdProducedEgg:Label
@export var DokibirdProducedChick:Label
@export var DokibirdProducedLong:Label
@export var DokibirdProducedBeeg:Label
@export var TricksterProducedEgg:Label
@export var TricksterProducedChick:Label
@export var TricksterProducedLong:Label
@export var TricksterProducedBeeg:Label

signal toMainMenu

func display():
	match VarGame.winner:
		0:winnerLabel.text = "Winner : Dokibird!"
		1:winnerLabel.text = "Winner : The Trikster!"
	dokiMoney.text = "Dokibird : "+str(VarGame.gold[0])
	triksterMoney.text = "Trikster : "+str(VarGame.gold[1])
	DokibirdProducedEgg.text 	= str(VarGame.unitProduced[0][0])
	DokibirdProducedChick.text 	= str(VarGame.unitProduced[0][1])
	DokibirdProducedLong.text 	= str(VarGame.unitProduced[0][2])
	DokibirdProducedBeeg.text 	= str(VarGame.unitProduced[0][3])
	TricksterProducedEgg.text 	= str(VarGame.unitProduced[1][0])
	TricksterProducedChick.text 	= str(VarGame.unitProduced[1][1])
	TricksterProducedLong.text 	= str(VarGame.unitProduced[1][2])
	TricksterProducedBeeg.text 	= str(VarGame.unitProduced[1][3])
	show()


func _on_to_main_menu_pressed() -> void:
	toMainMenu.emit()
