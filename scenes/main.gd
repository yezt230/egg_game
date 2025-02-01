extends Node2D

@export var EnemyScene: PackedScene
@onready var HealthManager = $HealthManager
@onready var Score = $Score

func _on_enemy_spawn_timer_timeout():
	var enemy_instance = EnemyScene.instantiate()
	var enemy_instance_animation = enemy_instance.get_node('AnimationPlayer') as AnimationPlayer
	var enemy_instance_sprite = enemy_instance.get_node('Sprite2D') as Sprite2D
	var animal = randi() % 3
	
	enemy_instance_animation.play("sliding")
	
	var h_position = 0
	var v_position = 0
	var h_rand = randi() % 2
	var v_rand = randi() % 2
	var enemy_scale = 1
	if h_rand == 0:
		h_position = 30
	else:
		h_position = 770
		enemy_scale = -1
		
	if v_rand == 0:
		v_position = 30
	else:
		v_position = 300	
		
	if animal == 0:
		enemy_instance_sprite.frame = 0
	elif animal == 1:
		enemy_instance_sprite.frame = 1
	elif animal == 2:
		enemy_instance_sprite.frame = 2
	enemy_instance.global_position = Vector2(h_position , v_position)
	add_child(enemy_instance)
	enemy_instance.scale.x = enemy_scale
	enemy_instance.connect("enemy_eaten", Callable(Score, "increment_score"))

	#Healh manager connection is here for now, but it'd be more
	#ideal to move this to its own scene and figure out how to
	#connect the signal there
	enemy_instance.connect("enemy_escaped", Callable(HealthManager, "_on_enemy_escaped"))
