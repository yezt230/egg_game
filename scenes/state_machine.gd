class_name StateMachine extends Node

@export var initial_state: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
	).call()

func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		#state_node.finished.connect(_transition_to_next_state)
		pass 
		
	await owner.ready
	state._enter_state("")
	
	
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
		
	var previous_state_path := state.name
	state._exit_state()
	state = get_node(target_state_path)
	state._enter_state(previous_state_path, data)
	
	
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	
	
func _process(delta: float) -> void:
	state._update_state(delta)
	
	
func _physics_process(delta: float) -> void:
	state._physics_update(delta)

#
#var current_state: State
#var states: Dictionary = {}
#
#func _ready():
	#for child in get_children():
		#if child is State:
			#states[child.name.to_lower()] = child
			#child.transition.connect(on_child_transition)
			#
	#if initial_state:
		#initial_state.Enter()
		#current_state = initial_state
			#
			#
#func _process(delta):
	#if current_state:
		#current_state._update_state(delta)
#
#
#func _physics_process(delta):
	#if current_state:
		#current_state._physics_update(delta)
#
#
#func on_child_transition(state, new_state_name):
	#if state != current_state:
		#return
		#
	#var new_state = states.get(new_state_name.to_lower())
