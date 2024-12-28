extends State

@export var poised_up_state: State
@export var poised_down_state: State

func enter() -> void:
	super()
	parent.player_animations.play('stifled_burp')


func on_enemy_eaten():
	pass


func _on_animation_player_animation_finished(anim_name):
	print("done")
	parent.state_machine.change_state(poised_up_state)
