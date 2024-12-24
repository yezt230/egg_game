extends State

@export var poised_up_state: State

func enter() -> void:
	super()
	parent.player_animations.play('swallow_up')


func on_enemy_eaten():
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swallow_up":
		print("swallowed entirely")
		process_animation(poised_up_state)
		

func process_animation(anim_name) -> State:
	print("processed")
	return poised_up_state
