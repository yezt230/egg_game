extends Node

@export var initial_state: StateMachine

var current_state: StateMachine
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is StateMachine:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
			
			
func _process(delta):
	pass
	#if current_state:
		#current_state.


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
