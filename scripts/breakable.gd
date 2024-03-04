extends StaticBody2D

var timer = 0
var break_timer = 0
var alive = true

func _process(delta):
	if not alive:
		timer += delta
	if timer > 3:
		revive()
	var has = false
	for body in $Area2D.get_overlapping_bodies():
		if body is Player or body is Enemy:
			has = true
	if has:
		break_timer += delta
	else:
		break_timer = 0
	if break_timer > 1:
		die()

func die():
	$Sprite2D.hide()
	$CollisionShape2D.disabled = true
	alive = false
	timer = 0
	break_timer = 0
func revive():
	$Sprite2D.show()
	$CollisionShape2D.disabled = false
	alive = true
	timer = 0
	break_timer = 0

func _on_visible_on_screen_notifier_2d_screen_exited():
	revive()

