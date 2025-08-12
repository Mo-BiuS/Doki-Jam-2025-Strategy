class_name BuyMenu extends PanelContainer

@export var dragoonEggButton:Button
@export var dragoonNormalButton:Button
@export var dragoonLongButton:Button
@export var dragoonBeegButton:Button

@export var mvmStat:Label
@export var attackStat:Label
@export var defenceStat:Label


signal buyUnit(n:int)

func _ready() -> void:
	dragoonEggButton.text = str(CONST_UNIT.array[0][5]) + " : " + str(CONST_UNIT.array[0][0])
	dragoonNormalButton.text = str(CONST_UNIT.array[1][5]) + " : " + str(CONST_UNIT.array[1][0])
	dragoonLongButton.text = str(CONST_UNIT.array[2][5]) + " : " + str(CONST_UNIT.array[2][0])
	dragoonBeegButton.text = str(CONST_UNIT.array[3][5]) + " : " + str(CONST_UNIT.array[3][0])
	
func setVisible(b:bool):
	if(b):
		refreshStat(0)
		dragoonEggButton.grab_focus()
		dragoonEggButton.disabled = !(VarGame.gold[VarGame.teamTurn] >= CONST_UNIT.array[0][5])
		dragoonNormalButton.disabled = !(VarGame.gold[VarGame.teamTurn] >= CONST_UNIT.array[1][5])
		dragoonLongButton.disabled = !(VarGame.gold[VarGame.teamTurn] >= CONST_UNIT.array[2][5])
		dragoonBeegButton.disabled = !(VarGame.gold[VarGame.teamTurn] >= CONST_UNIT.array[3][5])

		show()
	else:
		hide()

func refreshStat(i:int):
	mvmStat.text = str("Deplacement : ") + str(CONST_UNIT.array[i][1])
	attackStat.text = str("Attack : ") + str(CONST_UNIT.array[i][3])
	defenceStat.text = str("Defence : ") + str(CONST_UNIT.array[i][4])

func _on_dragoon_egg_pressed() -> void:
	buyUnit.emit(0)
func _on_dragoon_normal_pressed() -> void:
	buyUnit.emit(1)
func _on_dragoon_long_pressed() -> void:
	buyUnit.emit(2)
func _on_dragoon_beeg_pressed() -> void:
	buyUnit.emit(3)


func _on_dragoon_egg_focus_entered() -> void:
	refreshStat(0)


func _on_dragoon_normal_focus_entered() -> void:
	refreshStat(1)


func _on_dragoon_long_focus_entered() -> void:
	refreshStat(2)


func _on_dragoon_beeg_focus_entered() -> void:
	refreshStat(3)
