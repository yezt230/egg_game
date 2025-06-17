extends CharacterBody2D

@warning_ignore("unused_signal")
signal enemy_eaten
@warning_ignore("unused_signal")
signal enemy_escaped

@onready var enemy_sprite = $Sprite2D
@onready var enemy_animations = $AnimationPlayer
@onready var belch_initiator: bool = false
@onready var spawn_top_left = get_node("/root/Main/Platforms/MarkerTopLeft")
@onready var spawn_top_right = get_node("/root/Main/Platforms/MarkerTopRight")
@onready var spawn_bottom_left = get_node("/root/Main/Platforms/MarkerBottomLeft")
@onready var spawn_bottom_right = get_node("/root/Main/Platforms/MarkerBottomRight")
#@onready var score_scene = get_node("/root/Main/Score")
@onready var falling_label = $FallingLabel
@onready var collision_shape = $CollisionShape2D

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
var is_on_branch = false
var regex = RegEx.new()

func _ready():
	determine_spot()
#	Probably going to replace this, make
#	it dependent on the score later on
#	1/3 chance of causing a belch
	#var belch_probability = randi() % 3	
	#var belch_probability = 2	
	#if belch_probability == 2:
	#if score_array.has(score_scene.score):
		#belch_initiator = true
		#print("the array has a score of " + str(score_scene.score))
	
	regex.compile(".*Platform.*")
	
	enemy_animations.play("sliding")
	var animal = randi() % 3
	set_animal(animal)
			

func _physics_process(delta):		
	#falling_speed is really the overall movement speed
	var falling_speed = GRAVITY * delta
	if not is_on_branch and get_global_position().y > 375:
		collision_shape.disabled = true
	move_and_slide()
	if get_slide_collision_count() > 0:
		for i in range(get_slide_collision_count()):
			var collider_name = get_slide_collision(i).get_collider().name
			if regex.search(collider_name):
				is_on_branch = true
		set_animal(animal_type)
		enemy_animations.play("sliding")
	else:
		is_on_branch = false
		falling_speed = GRAVITY * delta
		enemy_animations.play("falling")
		match animal_type:
			0:
				enemy_sprite.frame = 12
				#animal_type = 0
			1:
				enemy_sprite.frame = 13
				#animal_type = 1
			2:
				enemy_sprite.frame = 14
				#animal_type = 2
		
	if is_on_branch:
		falling_label.text = "on branch"
	else:
		falling_label.text = "falling"
		
	for i in range(get_slide_collision_count()):
		var collider_name = get_slide_collision(i).get_collider().name
		if collider_name == "Player" and not has_been_eaten:
			has_been_eaten = true
			emit_signal("enemy_eaten")
			queue_free()			
			#The line below searches for collision names matching
			#the string in regex ("Platform") perhaps? 
		if regex.search(collider_name):			
			falling_speed = move_speed * delta		


			
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
	var enemy_scale = 1		
	var spawn_position_picker = randi() % 4
	var possible_positions = [spawn_top_left, spawn_top_right, spawn_bottom_left, spawn_bottom_right]
	var spawn_position = possible_positions[spawn_position_picker]	
	if spawn_position_picker == 1 or spawn_position_picker == 3:
		enemy_scale = -1		
	self.global_position = spawn_position.global_position	
	self.scale.x = enemy_scale


func set_animal(animal):
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


func set_speed_increase(speed_increase):
	move_speed = GRAVITY + speed_increase
	
