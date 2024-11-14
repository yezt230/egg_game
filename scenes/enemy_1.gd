extends CharacterBody2D

signal enemy_eaten

const GRAVITY = 25000
const MOVE_SPEED = 10000
const FLOOR_NORMAL = Vector2.UP

func _physics_process(delta):	
	velocity.y = GRAVITY * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("colilided with ", collision.get_collider().name)
		if collision.get_collider().name == "Player":
			print("thing")
			emit_signal("enemy_eaten")
			queue_free()
	

func _on_lifespan_timer_timeout():
	#pass # Replace with function body.
	queue_free()
