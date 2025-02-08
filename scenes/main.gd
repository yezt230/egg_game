extends Node2D

@export var EnemyScene: PackedScene
@export var end_screen_scene: PackedScene
@onready var HealthManager = $HealthManager
@onready var Score = $Score

func _ready():
	$%HealthManager.no_health.connect(on_no_health)

func _on_enemy_spawn_timer_timeout():
	var enemy_instance = EnemyScene.instantiate()
	add_child(enemy_instance)
	enemy_instance.connect("enemy_eaten", Callable(Score, "increment_score"))

	#Healh manager connection is here for now, but it'd be more
	#ideal to move this to its own scene and figure out how to
	#connect the signal there
	enemy_instance.connect("enemy_escaped", Callable(HealthManager, "_on_enemy_escaped"))


func on_no_health():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat(Score.count_text.text)
