extends CharacterBody2D

const GRAVITY = 25000
const MOVE_SPEED = 10000
const FLOOR_NORMAL = Vector2.UP

func _physics_process(delta):	
	velocity.y = GRAVITY * delta
	#if is_on_floor():
		##velocity.x += MOVE_SPEED * delta
		#velocity.x = MOVE_SPEED * delta
	#else:
		#velocity.y += GRAVITY * delta
	move_and_slide()
