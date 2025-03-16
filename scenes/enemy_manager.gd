extends Node

@export var enemy_scene: PackedScene

@onready var timer = $Timer

var spawn_time = 0

func _ready():
	var enemy = enemy_scene.instantiate() as Node2D
	
	spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	print("stuff")
	timer.start()
	
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)
	#var main_scene = get_tree().get_first_node_in_group("main")
	#print(main_scene)
	#enemy_instance.connect("enemy_eaten", Callable(Score, "increment_score"))

	#Healh manager connection is here for now, but it'd be more
	#ideal to move this to its own scene and figure out how to
	#connect the signal there
	#enemy_instance.connect("enemy_escaped", Callable(HealthManager, "_on_enemy_escaped"))
