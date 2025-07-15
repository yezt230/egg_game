extends State

@export var poised_up_state: State
@export var poised_down_state: State
@onready var score_scene = get_node("/root/Main/Score")
var reserved_state

func enter() -> void:
	super()
	reserved_state = parent.reserved_state
	parent.burp_counter += 1
	if not parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	if parent.burp_counter % 3 == 0:
		parent.player_animations.play('belch')
	else:
		parent.player_animations.play('stifled_burp')


func exit():
	if parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.disconnect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))


func on_enemy_eaten():
	pass


func _on_animation_player_animation_finished(_anim_name):
	parent.burp_queued = false
	if reserved_state == "swallow_up":
		parent.state_machine.change_state(poised_up_state)
	elif reserved_state == "swallow_down":
		parent.state_machine.change_state(poised_down_state)
