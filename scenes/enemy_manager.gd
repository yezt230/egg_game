extends Node

@export var enemy_scene: PackedScene

@onready var timer = $Timer

var spawn_time = 0
var speed_increase = 0
var max_speed = 30000
var speed_increase_increment = 10000
var speed_increase_amt = 2
var speed_increase_tick = 0

func _ready():
	var enemy = enemy_scene.instantiate() as Node2D
	
	spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	timer.start()
	
	var enemy_instance = enemy_scene.instantiate()
	
	enemy_instance.enemy_eaten.connect(_on_enemy_eaten)
	if enemy_instance.has_method("set_speed_increase"):
		enemy_instance.set_speed_increase(speed_increase)
		
	add_child(enemy_instance)
	#var main_scene = get_tree().get_first_node_in_group("main")
	#enemy_instance.connect("enemy_eaten", Callable(Score, "increment_score"))

	#Healh manager connection is here for now, but it'd be more
	#ideal to move this to its own scene and figure out how to
	#connect the signal there
	#enemy_instance.connect("enemy_escaped", Callable(HealthManager, "_on_enemy_escaped"))

func _on_enemy_eaten():
	speed_increase_tick += 1
	if speed_increase_tick >= speed_increase_amt:
		if speed_increase < max_speed:
			speed_increase += speed_increase_increment
			speed_increase_tick = 0
		print("speed_increase: " + str(speed_increase))
		print("speed_increase_increment: " + str(speed_increase_increment))
