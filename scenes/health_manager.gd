extends Node2D

@export var HealthBar: PackedScene
const starting_health = 3
var current_health = starting_health
var healthbar_array = []

func _ready():
	for health in starting_health:
		var single_bar = HealthBar.instantiate()
		single_bar.global_position = Vector2(700 + (16 * health), 48)
		add_child(single_bar)
		healthbar_array.append(single_bar)

		
func _on_enemy_escaped():
	current_health -= 1
	healthbar_array[current_health].lost_health()
