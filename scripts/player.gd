extends CharacterBody2D
class_name Player

@export var GRAVITY = 980

@export var speed = 7000
@export var jump_height = 300
@export var friction = 15
@export var coyote = 0.1
@export var pre_jump = 0.1
@export var jump_cancel_speed = 2

@export var loading:Control

var last_jump = 100
var last_ground = 100
var in_air = false
var is_running = false

var alive = true
var f = false

func _ready():
	pass
	##$DeathAnimation.play("RESET")
	
func _physics_process(delta):
	if f:
		velocity = Vector2.ZERO
		return
	var inp = Vector2.ZERO
	if alive: 
		last_jump += delta
		last_ground += delta
		if Input.is_action_just_pressed("move_jump"):
			last_jump = 0
		var fake_jump = Input.is_action_pressed("move_jump") and velocity.y < 0
		if is_on_floor():
			last_ground = 0
		if is_on_floor() and in_air:
			in_air = false
			if is_on_grass():
				$LandGrass.play()
			else:
				$LandStone.play()
			$AnimatedSprite2D.play_backwards("jump")
		if (is_on_floor() or last_ground < coyote) and last_jump < pre_jump:
			last_ground = 1
			last_jump = 1
			velocity.y = -sqrt(2 * GRAVITY * jump_height)
			if is_on_grass():
				$JumpGrass.play()
			else:
				$JumpStone.play()
			$AnimatedSprite2D.play("jump", 0.5)
			in_air = true
			is_running = false
		else:
			velocity.y += GRAVITY * delta * (1 if fake_jump else jump_cancel_speed)
			
		inp = Vector2(Input.get_axis("move_left", "move_right"), 0)
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = false
		if inp != Vector2.ZERO and is_on_floor() and not is_running and not in_air:
			is_running = true
			$AnimatedSprite2D.play("run")
		if inp == Vector2.ZERO and is_on_floor() and not in_air:
			is_running = false
			$AnimatedSprite2D.play("idle")
		
	else:
		velocity.y += GRAVITY * delta
		
	velocity += inp * speed * delta / 2
	move_and_slide()
	velocity += inp * speed * delta / 2
	velocity.x *= exp(-friction * delta)
	
	if position.y > 2000:
		die()
	
	
func die():
	if not alive: return
	$DeathTimer.start()
#	$DeathAnimation.play("die")
	loading.hide_level()
	alive = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.stop()
func bounce():
	velocity.y = -sqrt(3 * GRAVITY * jump_height)


func _on_death_timer_timeout():
	Globals.load_coins()
	get_tree().reload_current_scene()


func on_running_finished():
	if is_running and not is_on_grass() and is_on_floor():
		$RunningStone.play()
	elif is_running and is_on_floor():
		$RunningGrass.play()

func is_on_grass():
	var thing = get_last_slide_collision()
	if not thing:
		return false
	return thing.get_collider().is_in_group("ground")

func freeze():
	f = true
