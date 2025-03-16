extends State

@export var poised_up_state: State
@export var poised_down_state: State

func enter() -> void:
	super()
	if not parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	parent.player_animations.play('stifled_burp')


func exit():
	if parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.disconnect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))


func on_enemy_eaten():
	pass


func _on_animation_player_animation_finished():
	parent.state_machine.change_state(poised_up_state)
