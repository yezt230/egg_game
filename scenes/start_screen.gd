extends CanvasLayer

@onready var main_buttons = [$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StartButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingsButton,
$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/CreditsButton]
@onready var title_label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/TitleLabel
@onready var main_menu_button = %MainButton
@onready var burp_toggle = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BurpToggle
@onready var music_toggle = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MusicToggle
@onready var music_playing = false

var game_title = GameState.game_title
var states = ["main", "settings", "credits"]
var state = states[0]


func _ready():	
	title_label.text = game_title
	print(str(MusicPlayer.volume_db))
	main_menu_button.visible = false
	MusicPlayer.pitch_scale = 0.85


func _process(delta):
	if Input.is_action_just_pressed('start'):
		start_game()
		
		
func _on_start_button_pressed():
	start_game()


func _on_settings_button_pressed():
	change_display(1, "Settings")
	toggle_settings_buttons()
	
	
func _on_credits_button_pressed():
	change_display(2, "Credits")
	toggle_settings_buttons()


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
	title_label.text = game_title
	change_display(0, "Woods Food")
	toggle_settings_buttons()
	show_main_buttons()


func change_display(state_chosen: int, title_text: String):
	state = states[state_chosen]
	title_label.text = title_text
	hide_main_buttons()


func _on_main_button_pressed():	
	return_to_main()	


func toggle_settings_buttons():
	if state == "settings":
		burp_toggle.visible = true
		music_toggle.visible = true
	else:
		burp_toggle.visible = false
		music_toggle.visible = false
	
		
func start_game():
	if burp_toggle.button_pressed:
		GameState.burp_enabled = true
	else:
		GameState.burp_enabled = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_music_toggle_pressed():
	if music_playing:
		MusicPlayer.play()
		music_playing = false
	else:
		MusicPlayer.stop()
		music_playing = true
