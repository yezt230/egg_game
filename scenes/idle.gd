extends State

@export var poised_up_state: State
@export var poised_down_state: State
@export var stifled_state: State

func enter() -> void:
	super()
	parent.player_animations.play('idle')
	

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		parent.player_animations.play('up_poised')
		return poised_up_state
	elif Input.is_action_just_pressed('down'):
		parent.player_animations.play('down_poised')
		return poised_down_state
	return null

func process_physics(delta: float) -> State:
	return null
