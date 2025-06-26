extends CanvasLayer

@onready var count_text = $MarginContainer/EnemyCount

func _ready():
	update_score()


func increment_score():
	GameState.global_score += 1
	update_score()


func update_score():
	count_text.text = str(GameState.global_score)
