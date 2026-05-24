extends Label 
# displays player's treasure count on screen
func _process(_delta: float):
	var player = get_node("root/Level_1/Player")
	if player:
		text = player.treasure
