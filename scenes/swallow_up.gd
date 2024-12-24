extends State

@export var poised_up_state: State

func enter() -> void:
	super()
	parent.player_animations.play('swallow_up')


func on_enemy_eaten():
	#parent.player_animations.play('swallow_up')
	pass


func _on_animation_player_animation_finished(anim_name):	
	parent.state_machine.change_state(poised_up_state)
