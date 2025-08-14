class_name EndScreen extends CanvasLayer

signal toMainMenu

func _on_main_menut_button_pressed() -> void:
	toMainMenu.emit()
