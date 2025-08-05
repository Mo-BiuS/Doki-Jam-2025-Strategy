class_name BuyMenu extends PanelContainer

@export var dragoonEggButton:Button
@export var dragoonNormalButton:Button
@export var dragoonLongButton:Button
@export var dragoonBeegButton:Button

func _ready() -> void:
	dragoonEggButton.text = str(CONST_UNIT.array[0][5]) + dragoonEggButton.text
	dragoonNormalButton.text = str(CONST_UNIT.array[1][5]) + dragoonNormalButton.text
	dragoonLongButton.text = str(CONST_UNIT.array[2][5]) + dragoonLongButton.text
	dragoonBeegButton.text = str(CONST_UNIT.array[3][5]) + dragoonBeegButton.text

func setVisible(b:bool):
	if(b):
		dragoonEggButton.grab_focus()
		show()
	else:
		hide()
