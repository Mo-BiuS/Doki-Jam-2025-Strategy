class_name EscapeMenu extends PanelContainer

@onready var endTurnButton:Button = $Main/VBoxContainer/EndTurnButton
@onready var noSurrenderButton:Button = $Confirm/VBoxContainer/HBoxContainer/noSurrender

@onready var mainMenu:Control = $Main
@onready var confirmMenu:Control = $Confirm

signal endTurn()
signal surrender()

func setVisible(b:bool):
	if(b):
		mainMenu.show()
		confirmMenu.hide()
		endTurnButton.grab_focus()
		show()
	else:hide()

func _on_end_turn_button_pressed() -> void:
	endTurn.emit()


func _on_surrender_button_pressed() -> void:
	mainMenu.hide()
	confirmMenu.show()
	noSurrenderButton.grab_focus()


func _on_no_surrender_pressed() -> void:
	setVisible(true)


func _on_yes_surrender_pressed() -> void:
	surrender.emit()
