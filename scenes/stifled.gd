extends State

@export var poised_up_state: State
@export var poised_down_state: State
@onready var score_scene = get_node("/root/Main/Score")
@onready var stifled_array = [8,14,20]

func enter() -> void:
	super()
	parent.burp_counter += 1
	if not parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	#if score_scene.score <= 0:
	#if stifled_array.has(score_scene.score):
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
	parent.state_machine.change_state(poised_up_state)
