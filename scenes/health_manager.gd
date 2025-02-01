extends Node2D

@export var HealthBar: PackedScene
const starting_health = 3

func _ready():
	var enemy = get_node('../Enemy1')
	enemy.enemy_eaten.connect("_on_enemy_eaten")
	for health in starting_health:
		print(str(health))
		var single_bar = HealthBar.instantiate()
		single_bar.global_position = Vector2(700 + (24 * health), 48)
		add_child(single_bar)
		
		
		
func _on_enemy_eaten():
	print("healthed")


func delete_bar():
	print("delete bar func")
