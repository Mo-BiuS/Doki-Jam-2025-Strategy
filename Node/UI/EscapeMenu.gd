class_name EscapeMenu extends PanelContainer

@onready var endTurnButton:Button = $MarginContainer2/VBoxContainer/EndTurnButton

signal endTurn()

func setVisible(b:bool):
	if(b):
		endTurnButton.grab_focus()
		show()
	else :hide()

func _on_end_turn_button_pressed() -> void:
	endTurn.emit()
