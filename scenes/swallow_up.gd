extends State

@export var poised_up_state: State
@export var stifled_state: State

@onready var burp_counter = 0

func enter() -> void:
	super()
	burp_counter += 1
	print(burp_counter)
	parent.player_animations.play('swallow_up')


func on_enemy_eaten():
	#parent.player_animations.play('swallow_up')
	pass


func _on_animation_player_animation_finished(anim_name):	
	if burp_counter >= 2:
		print("burp activated")
		burp_counter = 0
		parent.state_machine.change_state(stifled_state)
	else:
		parent.state_machine.change_state(poised_up_state)
