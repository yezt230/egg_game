extends State

@export var idle_state: State
@export var poised_down_state: State
@export var swallow_up_state: State
@export var stifled_state: State

var idle_timer
var collision
var player_sprite
var sprite_scale
var collision_coords

func enter() -> void:
	super()
	idle_timer = parent.idle_timer
	collision = parent.collision
	player_sprite = parent.player_sprite
	sprite_scale = parent.sprite_scale
	collision_coords = parent.collision_coords
	collision.global_position.y = collision_coords.top
	idle_timer.start()
	idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))
	
	parent.player_animations.play('up_poised')


func exit() -> void:
	idle_timer.stop()
	
	
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('down'):		
		return poised_down_state
	if Input.is_action_just_pressed('left'):
		collision.global_position.x = collision_coords.right
		player_sprite.scale.x = sprite_scale * 1
	elif Input.is_action_just_pressed('right'):
		collision.global_position.x = collision_coords.left
		player_sprite.scale.x = sprite_scale * -1
	elif Input.is_action_just_pressed('diagonal'):
		if collision.global_position.x == collision_coords.right:
			print("collision was left")
			collision.global_position.x = collision_coords.left
		elif collision.global_position.x == collision_coords.left:
			print("collision was right")
			collision.global_position.x = collision_coords.right
			print(str(collision.global_position.x))
		player_sprite.scale.x = player_sprite.scale.x * -1
		return poised_down_state
	return null
#

func _on_idle_timer_timeout():
	parent.state_machine.change_state(idle_state)


func on_enemy_eaten():
	return swallow_up_state
