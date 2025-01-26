extends CharacterBody2D

signal enemy_eaten

@onready var enemy_animations = $AnimationPlayer

const GRAVITY = 25000
const MOVE_SPEED = 10000
const FLOOR_NORMAL = Vector2.UP

func _ready():
	pass


func _physics_process(delta):	
	velocity.y = GRAVITY * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "Player":
			emit_signal("enemy_eaten")
			queue_free()
	

func _on_lifespan_timer_timeout():
	queue_free()
