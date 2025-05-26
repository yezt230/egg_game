extends CanvasLayer

@onready var count_text = $MarginContainer/EnemyCount
var score = 0


func _ready():
	update_score()


func increment_score():
	score += 1
	update_score()


func update_score():
	count_text.text = str(score)
