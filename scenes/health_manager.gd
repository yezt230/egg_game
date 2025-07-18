extends Node2D

signal no_health

@export var HealthBar: PackedScene
#starting health for the healthbar, change this to
#actual number for gameplay
const starting_health = 3
#const DEBUG = true
const DEBUG = false

var current_health = starting_health
var healthbar_array = []

func _ready():
	for health in starting_health:
		var single_bar = HealthBar.instantiate()
		single_bar.global_position = Vector2(700 + (16 * health), 48)
		add_child(single_bar)
		healthbar_array.append(single_bar)

		
func _on_enemy_escaped():
	if current_health > 0:		
		#DEBUG: switch the const DEBUG from false to true
		#to toggle debugging. Missing enemies will not 
		#lose health on debug mode
		
		if DEBUG:			
			return
		else:
			current_health -= 1
			healthbar_array[current_health].lost_health()
	else:
		no_health.emit()
