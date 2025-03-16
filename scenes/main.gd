extends Node2D

@export var EnemyScene: PackedScene
@export var end_screen_scene: PackedScene
@onready var HealthManager = $HealthManager
@onready var Score = $Score

#pine cones for "bomb" hazard?

func _ready():
	$%HealthManager.no_health.connect(on_no_health)


func on_no_health():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat(Score.count_text.text)
