extends CharacterBody2D

@export var GRAVITY = 980

@export var speed = 4500
@export var friction = 15

var inp
var alive = true

func _ready():
	inp = (randi() % 2)*2 - 1

func _physics_process(delta):
	if not alive:
		return
	velocity.y += GRAVITY * delta
	velocity.x += inp * speed * delta / 2
	move_and_slide()
	velocity.x += inp * speed * delta / 2
	velocity.x *= exp(-friction * delta)
	
	if position.y > 2000:
		die()
	
	if $LeftArea.has_overlapping_bodies():
		inp = 1
	if $RightArea.has_overlapping_bodies():
		inp = -1
	if not $LeftArea2.has_overlapping_bodies():
		inp = 1
	if not $RightArea2.has_overlapping_bodies():
		inp = -1
	
func die():
	hide()
	$CollisionShape2D.disabled = true
	alive = false
	velocity = Vector2.ZERO
	
func revive():
	show()
	$CollisionShape2D.disabled = false
	alive = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	revive()
