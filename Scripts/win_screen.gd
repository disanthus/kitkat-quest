extends Control

func _on_return_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
