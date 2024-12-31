extends Node2D

@export var EnemyScene: PackedScene


func _on_enemy_spawn_timer_timeout():
	var enemy_instance = EnemyScene.instantiate()
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
	
	enemy_instance.global_position = Vector2(h_position , v_position)
	add_child(enemy_instance)
	enemy_instance.scale.x = enemy_scale
	enemy_instance.connect("enemy_eaten", Callable($Score, "increment_score"))
