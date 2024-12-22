extends State

@export var idle_state: State
@export var poised_down_state: State
@export var stifled_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('down'):
		parent.player_animations.play('down_poised')
		return poised_down_state
	return null
#

func _on_idle_timer_timeout():
	return idle_state
