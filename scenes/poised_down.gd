extends State

@export var idle_state: State
@export var poised_up_state: State
@export var stifled_state: State

func enter() -> void:
	super()	
	#if not parent.idle_timer.is_connected("timeout", Callable(self, "_on_idle_timer_timeout")):
	parent.idle_timer.start()
	parent.idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))


func exit() -> void:
	parent.idle_timer.stop()
	

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		parent.player_animations.play('up_poised')
		return poised_up_state
	return null


func _on_idle_timer_timeout():
	parent.state_machine.change_state(idle_state)
