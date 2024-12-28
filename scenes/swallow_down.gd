extends State

@export var poised_down_state: State

@onready var burp_counter = 0

func enter() -> void:
	super()
	burp_counter += 1
	print(burp_counter)
	parent.player_animations.play('swallow_down')


func on_enemy_eaten():
	#parent.player_animations.play('swallow_up')
	pass


func _on_animation_player_animation_finished(anim_name):	
	parent.state_machine.change_state(poised_down_state)
