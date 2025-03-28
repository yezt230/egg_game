extends State

@export var poised_up_state: State
@export var poised_down_state: State
@export var stifled_state: State

var	player_sprite
var	sprite_scale
var collision

func enter() -> void:
	super()
	player_sprite = parent.player_sprite
	sprite_scale = parent.sprite_scale
	collision = parent.collision
	collision.global_position = Vector2(260, 25)
	parent.player_animations.play('idle')
	

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('up'):
		return poised_up_state
	elif Input.is_action_just_pressed('down'):
		return poised_down_state
	elif Input.is_action_just_pressed('left'):
		collision.global_position.x = 260
		player_sprite.scale.x = sprite_scale * 1
		return poised_up_state
	elif Input.is_action_just_pressed('right'):
		collision.global_position.x = 490
		player_sprite.scale.x = sprite_scale * -1
		return poised_up_state
	return null


func on_enemy_eaten():
	pass
