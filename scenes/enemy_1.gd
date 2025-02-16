extends CharacterBody2D

signal enemy_eaten
signal enemy_escaped

@onready var enemy_sprite = $Sprite2D
@onready var enemy_animations = $AnimationPlayer

const GRAVITY = 25000
const MOVE_SPEED = 10000
const FLOOR_NORMAL = Vector2.UP
var animals = {
	"rabbit": 0,
	"raccoon": 1,
	"beaver": 2
}
var animal_type = 0
var has_been_eaten = false
var has_escaped = false

func _ready():
	determine_spot()
	
	enemy_animations.play("sliding")
	var animal = randi() % 3
	match animal:
		0:
			enemy_sprite.frame = animals["rabbit"]
			animal_type = 0
		1:
			enemy_sprite.frame = animals["raccoon"]
			animal_type = 1
		2:
			enemy_sprite.frame = animals["beaver"]
			animal_type = 2
			

func _physics_process(delta):		
	var falling_speed = GRAVITY * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "Player" and not has_been_eaten:
			has_been_eaten = true
			emit_signal("enemy_eaten")
			queue_free()			
			
	if self.global_position.y > 500:		
		if not has_escaped:
			emit_signal("enemy_escaped")
			has_escaped = true		
		match animal_type:
			0:
				enemy_animations.play("rabbit_run")
			1:
				enemy_animations.play("raccoon_run")
			2:
				enemy_animations.play("beaver_run")
		velocity.y = falling_speed/4
		#@TODO: get better way of determining run direction, for
		#now they pause horizontally after hitting the halfway point
		if self.global_position.x < 400:
			velocity.x = falling_speed/4
		else:
			velocity.x = (falling_speed/4) * -1
	else:
		velocity.y = falling_speed
	

func _on_lifespan_timer_timeout():
	queue_free()


func determine_spot():	
	var h_position = 0
	var v_position = 0
	var h_rand = randi() % 2
	var v_rand = randi() % 2
	var enemy_scale = 1
	if h_rand == 0:
		h_position = -50
	else:
		h_position = 850
		enemy_scale = -1
		
	if v_rand == 0:
		v_position = 30
	else:
		v_position = 300
		
	self.global_position = Vector2(h_position , v_position)
	self.scale.x = enemy_scale


func set_animal():
	pass
