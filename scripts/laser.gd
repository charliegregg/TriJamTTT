extends Node2D

func _physics_process(delta):
	var p = %RayCast2D.get_collision_point()
	if not p:
		return
	var length = global_position.distance_to(p)
	$Beam.scale.y = length
	$EndSprite.position.y = -length


func _on_area_2d_body_entered(body):
	if body is Player or body is Enemy:
		body.die()
