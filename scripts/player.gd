extends CharacterBody2D

@export var GRAVITY = 980

@export var speed = 4500
@export var jump_height = 300
@export var friction = 15
@export var coyote = 0.1
@export var pre_jump = 0.1
@export var jump_cancel_speed = 3

var last_jump = 100
var last_ground = 100

func _ready():
	pass
	
func _physics_process(delta):
	last_jump += delta
	last_ground += delta
	if Input.is_action_just_pressed("move_jump"):
		last_jump = 0
	var fake_jump = Input.is_action_pressed("move_jump") and velocity.y < 0
	if is_on_floor():
		last_ground = 0
	if (is_on_floor() or last_ground < coyote) and last_jump < pre_jump:
		last_ground = 1
		coyote = 1
		velocity.y = -sqrt(2 * GRAVITY * jump_height)
	else:
		velocity.y += GRAVITY * delta * (1 if fake_jump else jump_cancel_speed)
		
	var inp = Vector2(Input.get_axis("move_left", "move_right"), 0)
	velocity += inp * speed * delta / 2
	move_and_slide()
	velocity += inp * speed * delta / 2
	velocity.x *= exp(-friction * delta)
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
