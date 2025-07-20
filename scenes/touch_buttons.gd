extends Node

@onready var player = %Player
@onready var top_left_button = $TopLeftButton
@onready var top_right_button = $TopRightButton
@onready var bottom_left_button = $BottomLeftButton
@onready var bottom_right_button = $BottomRightButton
@onready var state_machine = player.state_machine
@export var poised_up_state: State


func _on_top_left_button_pressed():
	map_directions("up", "left")


func _on_top_right_button_button_down():
	map_directions("up", "right")
	
	
func _on_bottom_left_button_pressed():
	map_directions("down", "left")	


func _on_bottom_right_button_pressed():
	map_directions("down", "right")
	

func map_directions(dir1, dir2):
	for dir in [dir1, dir2]:
		var press_event = InputEventAction.new()
		press_event.action = dir
		press_event.pressed = true
		Input.parse_input_event(press_event)
		
	await get_tree().create_timer(0.1).timeout
	for dir in [dir1, dir2]:
		var release_event = InputEventAction.new()
		release_event.action = dir
		release_event.pressed = false
		Input.parse_input_event(release_event)


func _on_button_spawn_timer_timeout():
	print("buttons visible)")
	top_left_button.visible = true
	top_right_button.visible = true
	bottom_left_button.visible = true
	bottom_right_button .visible = true
