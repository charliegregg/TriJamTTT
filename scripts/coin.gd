extends Area2D



func _on_body_entered(body):
	if body is Player:
		Globals.add_coin()
		queue_free()
