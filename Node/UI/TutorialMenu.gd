class_name TutorialMenu extends CanvasLayer

signal toMainMenu


func _on_prev_tutoriel_pressed() -> void:
	pass # Replace with function body.
func _on_next_tutoriel_pressed() -> void:
	pass # Replace with function body.
func _on_to_main_menu_pressed() -> void:
	toMainMenu.emit()
