class_name EndGameScreen extends PanelContainer

@export var winnerLabel:Label

signal toMainMenu

func display():
	match VarGame.winner:
		0:winnerLabel.text = "Winner : Dokibird!"
		1:winnerLabel.text = "Winner : The Trikster!"
	show()


func _on_to_main_menu_pressed() -> void:
	toMainMenu.emit()
