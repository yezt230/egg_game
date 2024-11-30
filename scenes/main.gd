extends Node2D

@export var EnemyScene: PackedScene


func _on_enemy_spawn_timer_timeout():
	var enemy_instance = EnemyScene.instantiate()
	
	enemy_instance.global_position = Vector2(randi() % 600, 19)
	add_child(enemy_instance)
	enemy_instance.connect("enemy_eaten", Callable($Score, "increment_score"))
