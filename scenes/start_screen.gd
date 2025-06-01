extends CanvasLayer

@onready var main_buttons = [$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StartButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingsButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/CreditsButton]
@onready var title_label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/TitleLabel
@onready var main_menu_button = %MainButton

var title = "Bear Game"
var states = ["main", "settings", "credits"]
var state = states[0]

func _ready():	
	main_menu_button.visible = false
	#main_buttons[1].visible = false
	
	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_button_pressed():
	change_display(1, "Settings")
	
	
func hide_main_buttons():
	for main_button in main_buttons:
		main_button.visible = false
	main_menu_button.visible = true
	

func show_main_buttons():
	for main_button in main_buttons:
		main_button.visible = true
	main_menu_button.visible = false


func return_to_main():
	state = states[0]
	title_label.text = title
	show_main_buttons()


func change_display(state_chosen: int, title_text: String):
	state = states[state_chosen]
	title_label.text = title_text
	hide_main_buttons()


func _on_main_button_pressed():
	return_to_main()	


func _on_credits_button_pressed():
	change_display(2, "Credits")
