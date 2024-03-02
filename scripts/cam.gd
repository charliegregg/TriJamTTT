extends Camera2D

@export var player: CharacterBody2D

var adjust_y: bool = false

func _physics_process(delta):
	position.x = lerp(position.x, player.position.x, 0.04)
	if abs(position.y - player.position.y) > 200:
		adjust_y = true
	if adjust_y:
		position.y = lerp(position.y, player.position.y, 0.04)
	if abs(position.y - player.position.y) < 20:
		adjust_y = false
