extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var main_scene = ResourceLoader.load("res://scenes/main.tscn")

func _ready():
	get_tree().paused = true
	print("printed")
	var main_instance = main_scene.instantiate()
	var score_node = main_instance.get_node("Score")
	var score = GameState.global_score
	#if main_scene:
		#score = main_scene.main_score
	print(str(score))
	score_label.text = "Your score: " + str(score)
#
#func set_defeat(score_string):
	#score_label.text = "Your score: " + str(score_string)


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
