extends State

@export var poised_up_state: State
@export var swallow_down_state: State
@export var stifled_state: State

var collision
var player_sprite
var sprite_scale
var collision_coords
var reserved_state

func enter() -> void:
	super()
	collision = parent.collision
	player_sprite = parent.player_sprite
	sprite_scale = parent.sprite_scale
	collision_coords = parent.collision_coords
	reserved_state = parent.reserved_state
	collision.global_position.y = collision_coords.top
	if not parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	parent.player_animations.play('swallow_up')
	parent.player_animations.seek(parent.current_swallow_progress, true)


func exit() -> void:
	parent.reserved_state = "swallow_up"
	if parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.disconnect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	if parent.player_animations.current_animation == "swallow_up":
		parent.current_swallow_progress = parent.player_animations.current_animation_position
	else:
		parent.current_swallow_progress = 0.0
	
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('down'):		
		return swallow_down_state
	if Input.is_action_just_pressed('left'):
		collision.global_position.x = collision_coords.right
		player_sprite.scale.x = sprite_scale * 1
	elif Input.is_action_just_pressed('right'):
		collision.global_position.x = collision_coords.left
		player_sprite.scale.x = sprite_scale * -1
	elif Input.is_action_just_pressed('diagonal'):
		if collision.global_position.x == collision_coords.right:
			collision.global_position.x = collision_coords.left
		elif collision.global_position.x == collision_coords.left:
			collision.global_position.x = collision_coords.right
		player_sprite.scale.x = player_sprite.scale.x * -1
		return swallow_down_state
	return null
	

func on_enemy_eaten():
	# restarts swallowing animation when
	# swallowing an enemy midway through
	# the first animation
	parent.player_animations.stop()
	parent.player_animations.play('swallow_up')


func _on_animation_player_animation_finished(anim_name):
	if parent.burp_queued and GameState.burp_enabled:
		parent.state_machine.change_state(stifled_state)
	else:
		if anim_name == 'swallow_up':
			parent.state_machine.change_state(poised_up_state)
