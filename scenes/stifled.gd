extends State

@export var idle_state: State
@export var poised_up_state: State
@export var poised_down_state: State

func enter() -> void:
	super()
	parent.player_animations.play('stifled_burp')

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		return poised_up_state
	elif Input.is_action_just_pressed('down'):
		return poised_down_state
	return null

#func process_physics(delta: float) -> State:
	#return null
