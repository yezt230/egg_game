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
