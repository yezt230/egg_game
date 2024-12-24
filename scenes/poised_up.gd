extends State

@export var idle_state: State
@export var poised_down_state: State
@export var swallow_up_state: State
@export var stifled_state: State

var idle_timer
var collision
var player_sprite
var sprite_scale

func enter() -> void:
	super()
	idle_timer = parent.idle_timer
	collision = parent.collision
	player_sprite = parent.player_sprite
	sprite_scale = parent.sprite_scale
	collision.global_position.y = 340
	idle_timer.start()
	idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))
	
	parent.player_animations.play('up_poised')


func exit() -> void:
	idle_timer.stop()
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('down'):
		
		return poised_down_state
	if Input.is_action_just_pressed('left'):
		collision.global_position.x = 260
		player_sprite.scale.x = sprite_scale * 1
	elif Input.is_action_just_pressed('right'):
		collision.global_position.x = 490
		player_sprite.scale.x = sprite_scale * -1
	return null
#

func _on_idle_timer_timeout():
	parent.state_machine.change_state(idle_state)


func on_enemy_eaten():
	print("eaten in poised up")
	return swallow_up_state
