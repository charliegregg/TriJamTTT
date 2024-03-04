extends Node


func _on_body_entered(body):
	if body is Player or body is Enemy:
		body.die()
