class_name TutorialMenu extends CanvasLayer

signal toMainMenu

@export var tutoContainer:Control
var pointer = 0

func _ready() -> void:
	refreshTuto()

func _on_prev_tutoriel_pressed() -> void:
	if(pointer+1 < tutoContainer.get_children().size()):pointer+=1
	else:pointer = 0
	refreshTuto()
func _on_next_tutoriel_pressed() -> void:
	if(pointer-1 >= 0):pointer-=1
	else:pointer = tutoContainer.get_children().size()-1
	refreshTuto()
func _on_to_main_menu_pressed() -> void:
	toMainMenu.emit()

func refreshTuto():
	for j in tutoContainer.get_children():
		if(j.name == "Tuto"+str(pointer)):j.show()
		else:j.hide()
