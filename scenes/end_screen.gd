extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var score_number_label = %ScoreNumberLabel
@onready var main_scene = ResourceLoader.load("res://scenes/main.tscn")

func _ready():
	var main_instance = main_scene.instantiate()
	var score = GameState.global_score
	score_number_label.text = str(score)
	
	
func _process(_delta):
		if Input.is_action_just_pressed('restart'):
			get_tree().change_scene_to_file("res://scenes/main.tscn")
			
	
func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
