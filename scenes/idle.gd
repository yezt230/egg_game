extends State

@export var poised_up_state: State
@export var stifled_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('down'):
		print('executed')
	else:
		print('not executed')
	return null

func process_physics(delta: float) -> State:
	#parent.velocity.y += gravity * delta
	#parent.move_and_slide()
	#
	#if !parent.is_on_floor():
		#return fall_state
	return null
