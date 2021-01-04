extends KinematicBody2D

var velocity = Vector2()
const UP = Vector2(0,-1)
const INITIAL_SPEED = 1
const SPEED = 3
const MAX_SPEED = 300
const GRAVITY = 35
const JUMP_FORCE = -750
var horizontal_input = false

func _physics_process(delta):
	horizontal_input = false
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		horizontal_input = true
		if is_on_floor():
			velocity.x = lerp(velocity.x, MAX_SPEED, 0.05)
		else:
			velocity.x = lerp(velocity.x, MAX_SPEED, 0.15)
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		horizontal_input = true
		if is_on_floor():
			velocity.x = lerp(velocity.x, -MAX_SPEED, 0.05)
		else:
			velocity.x = lerp(velocity.x, -MAX_SPEED, 0.15)
		
	velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	print(velocity.x)
	
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		
	velocity = move_and_slide(velocity, UP)
	
	if not horizontal_input and is_on_floor():
		velocity.x = lerp(velocity.x, 0,0.125)
