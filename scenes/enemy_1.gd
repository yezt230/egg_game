extends CharacterBody2D

signal enemy_eaten
signal enemy_escaped

@onready var enemy_sprite = $Sprite2D
@onready var enemy_animations = $AnimationPlayer

const GRAVITY = 25000
const MOVE_SPEED = 10000
const FLOOR_NORMAL = Vector2.UP

func _ready():
	enemy_animations.play("sliding")
	var animal = randi() % 3
	if animal == 0:
		#enemy_instance_sprite.frame = 0
		enemy_sprite.frame = 0
		print("animal" + str(animal))
	elif animal == 1:
		#enemy_instance_sprite.frame = 1
		enemy_sprite.frame = 1
		print("animal" + str(animal))
	elif animal == 2:
		#enemy_instance_sprite.frame = 2
		enemy_sprite.frame = 2
		print("animal" + str(animal))


func _physics_process(delta):
	var falling_speed = GRAVITY * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "Player":
			emit_signal("enemy_eaten")
			queue_free()
			
	if self.global_position.y > 500:		
		emit_signal("enemy_escaped")
		enemy_animations.play("rabbit_run")
		velocity.y = falling_speed/4
		velocity.x = falling_speed/4
	else:
		velocity.y = falling_speed
	

func _on_lifespan_timer_timeout():
	queue_free()
