extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#pass
	print('poised up')

func physics_update(_delta: float) -> void:
	print('poised up update')
