extends CharacterBody2D

@warning_ignore("unused_signal")
signal enemy_eaten
@warning_ignore("unused_signal")
signal enemy_escaped

@onready var enemy_sprite = $Sprite2D
@onready var enemy_animations = $AnimationPlayer
@onready var belch_initiator: bool = false

const GRAVITY = 25000
const FLOOR_NORMAL = Vector2.UP

var animals = {
	"rabbit": 0,
	"raccoon": 1,
	"beaver": 2
}
var animal_type = 0
var has_been_eaten = false
var has_escaped = false
var move_speed = 0
var regex = RegEx.new()

func _ready():
	determine_spot()
	
#	Probably going to replace this, make
#	it dependent on the score later on
	var belch_probability = randi() % 3
	if belch_probability == 2:
		belch_initiator = true
	
	regex.compile(".*Platform.*")
	
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
	#falling_speed is really the overall movement speed
	var falling_speed = GRAVITY * delta
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		var collider_name = collision.get_collider().name
		if collider_name == "Player" and not has_been_eaten:
			has_been_eaten = true
			emit_signal("enemy_eaten")
			queue_free()
			
		if regex.search(collider_name):
			falling_speed = move_speed * delta
		else:
			falling_speed = GRAVITY * delta
			
	if self.global_position.y > 550:		
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


func set_speed_increase(speed_increase):
	#return speed_increase
	move_speed = GRAVITY + speed_increase
	
