extends Node2D

@export var EnemyScene: PackedScene
@export var end_screen_scene: PackedScene
@onready var HealthManager = $HealthManager
@onready var platforms = $Platforms
@onready var Score = $Score
@onready var speed_label = $SpeedLabel
@onready var enemy_manager = $EnemyManager

@onready var main_score: int = 0

func _ready():
	GameState.global_score = 0
	MusicPlayer.pitch_scale = GameState.music_pitch 
	Score.count_text.text = str(GameState.global_score)
	$%HealthManager.no_health.connect(on_no_health)
	platforms.z_index = 100


func on_no_health():
	main_score = GameState.global_score
	get_tree().change_scene_to_file("res://scenes/end_screen_display.tscn")
