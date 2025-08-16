class_name MainMenu extends CanvasLayer

signal goCampagn
signal goTutorial
signal goSkirmish

func _on_campagn_mode_pressed() -> void:
	goCampagn.emit()
func _on_tutorial_mode_pressed() -> void:
	goTutorial.emit()
func _on_skirmish_mod_pressed() -> void:
	goSkirmish.emit()
