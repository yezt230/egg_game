extends Node

@export var enemy_scene: PackedScene

@onready var timer = $SpawnTimer
@onready var delay_timer = $SpawnDelayTimer
@onready var player = $"../Player"
@onready var HealthManager = get_parent().get_node("HealthManager")
@onready var Score = get_parent().get_node("Score")

var spawn_time = 0
var speed_increase = 0
var max_speed = 30000

#DEBUG: un/comment speed_increase_increment
var speed_increase_increment = 10000
#var speed_increase_increment = 0
var speed_increase_amt = 2
var speed_increase_tick = 0
var burp_score_array = []
#var burp_score_array = [4,8,12,16,20,24,28]

#var stifled_array = [10,20,30,40,50]
#var score_array = [4,8,12,16,20]
var already_generated_belch_initiators_scores = []
var will_generate_belch_initiator = false

func _ready():
	for i in 50:
		burp_score_array.append(i*4)
	var _enemy = enemy_scene.instantiate() as Node2D	
	spawn_time = timer.wait_time


func _on_timer_timeout():
	#print("new prey spawned and belch is set to " + str(will_generate_belch_initiator))
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.z_index = 0
	enemy_instance.z_as_relative = false
	enemy_instance.enemy_eaten.connect(_on_enemy_eaten)
	if enemy_instance.has_method("set_speed_increase"):
		enemy_instance.set_speed_increase(speed_increase)		
	add_child(enemy_instance)
	if will_generate_belch_initiator:
		enemy_instance.belch_initiator = true
		will_generate_belch_initiator = false
		timer.stop()
		delay_timer.start()
		
	
	enemy_instance.connect("enemy_eaten", Callable(Score, "increment_score"))
	# Healh manager connection is here for now, but it'd be more
	# ideal to move this to its own scene and figure out how to
	# connect the signal there
	enemy_instance.connect("enemy_escaped", Callable(HealthManager, "_on_enemy_escaped"))
	

func _process(_delta):
	pass


func _on_enemy_eaten():
	determine_belch_initiator()
	
	speed_increase_tick += 1
	if speed_increase_tick >= speed_increase_amt:
		if speed_increase < max_speed:
			speed_increase += speed_increase_increment
			speed_increase_tick = 0


func _on_spawn_delay_timer_timeout():
	timer.start()
	delay_timer.stop()


func _on_start_spawn_timer_timeout():
	timer.start()
	
	
func determine_belch_initiator():
	var score = GameState.global_score
	if burp_score_array.has(score) and not already_generated_belch_initiators_scores.has(score):		
		already_generated_belch_initiators_scores.append(score)
		will_generate_belch_initiator = true
