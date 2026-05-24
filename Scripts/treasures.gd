extends Node2D

var treasure = 0
func treasure_counter():
	treasure += 1
	if treasure == 2:
		get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
