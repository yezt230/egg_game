extends CanvasLayer

@onready var main_buttons = [$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StartButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingsButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/CreditsButton]
@onready var title_label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/TitleLabel

var states = ["main", "settings", "credits"]
var state = states[0]

func _ready():	
	pass
	#main_buttons[1].visible = false
	
	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_button_pressed():
	state = states[1]
	title_label.text = "Settings"
	hide_main_buttons()
	
	
func hide_main_buttons():
	for main_button in main_buttons:
		main_button.visible = false
