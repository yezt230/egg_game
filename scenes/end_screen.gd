extends CanvasLayer

func _ready():
	get_tree().paused = true

func set_defeat(score_string):
	$%ScoreLabel.text = "Your score: " + str(score_string)


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
