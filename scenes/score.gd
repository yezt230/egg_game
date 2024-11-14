extends CanvasLayer

@export var score: int = 0

@onready var count_text = $EnemyCount
var enemy_count = 0


func _ready():
	update_score()


func increment_score():
	print("eatn")
	enemy_count += 1
	update_score()


func update_score():
	count_text.text = str(enemy_count)
