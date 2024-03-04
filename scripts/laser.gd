extends Node2D

@export var cycle: float = 4.0
@export var start: float = 1.0
@export var end: float = 3.0
@export var spin: float = 0.0


var timer = 0
var enabled = true

func _physics_process(delta):
	var p = %RayCast2D.get_collision_point()
	if not p:
		return
	var length = global_position.distance_to(p)
	$Beam.scale.y = length
	$EndSprite.position.y = -length
	
	timer = fmod(timer + delta, cycle)
	if timer > start and timer <= end:
		if not enabled:
			start_enable()
	else:
		if enabled:
			start_disable()
	rotation += 2 * PI * delta * spin

func enable():
	$PulseSound.play()
	$Beam/Area2D/CollisionShape2D.disabled = false
	$Beam/Sprite2D.show()
	$EndSprite.show()
	
func disable():
	$Beam/Area2D/CollisionShape2D.disabled = true
	$Beam/Sprite2D.hide()
	$EndSprite.hide()
	

func start_enable():
	enabled = true
	$ChargeTimer.start()
	$ChargeSound.play()
func start_disable():
	enabled = false
	$FireTimer.start()

func _on_area_2d_body_entered(body):
	if body is Player or body is Enemy:
		body.die()
