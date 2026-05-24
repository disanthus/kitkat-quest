extends Area2D

# specifies only player can collect item
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
