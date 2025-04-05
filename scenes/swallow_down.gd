extends State

@export var poised_down_state: State
@export var poised_up_state: State

var collision
var player_sprite
var sprite_scale
var collision_coords

func enter() -> void:
	super()
	collision = parent.collision
	player_sprite = parent.player_sprite
	sprite_scale = parent.sprite_scale
	collision_coords = parent.collision_coords
	
	if not parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	parent.player_animations.play('swallow_down')


func exit():
	if parent.player_animations.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		parent.player_animations.disconnect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))


func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		#idle_timer.restart()
		return poised_up_state
	if Input.is_action_just_pressed('left'):
		print("left")
		collision.global_position.x = collision_coords.right
		#idle_timer.restart()
		player_sprite.scale.x = sprite_scale * 1
	elif Input.is_action_just_pressed('right'):
		print("right")
		collision.global_position.x = collision_coords.left
		player_sprite.scale.x = sprite_scale * -1
	elif Input.is_action_just_pressed('diagonal'):
		if collision.global_position.x == collision_coords.right:
			print("collision was left")
			collision.global_position.x = collision_coords.left
		elif collision.global_position.x == collision_coords.left:
			print("collision was right")
			collision.global_position.x = collision_coords.right
		player_sprite.scale.x = player_sprite.scale.x * -1
		return poised_up_state
	return null
	

func on_enemy_eaten():
	pass
	

func _on_animation_player_animation_finished(anim_name):	
	parent.state_machine.change_state(poised_down_state)
