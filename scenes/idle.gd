extends State

@export var poised_up_state: State
@export var poised_down_state: State
@export var stifled_state: State

func enter() -> void:
	super()
	parent.player_animations.play('idle')
	

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		return poised_up_state
	elif Input.is_action_just_pressed('down'):
		return poised_down_state
	return null


func on_enemy_eaten():
	pass
