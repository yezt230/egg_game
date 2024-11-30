extends CharacterBody2D



@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var idle_timer = $IdleTimer

@onready var facing_left = false
@onready var standing_up = true
@onready var idling = true
@onready var sprite_scale = 0.5

func _ready():
	player_animations.play("idle")


#More optimal way to assign multiple values at once?
#TODO: top-level collision is misaligned until player presses a lower button
func _process(delta):	
	if Input.is_action_just_pressed("up"):
		var input_values = input_movement(300, true)
		collision.global_position.y = input_values[0]
		standing_up = input_values[1]
	elif Input.is_action_just_pressed("down"):	
		var input_values = input_movement(450, false)
		collision.global_position.y = input_values[0]
		standing_up = input_values[1]
	if Input.is_action_just_pressed("left"):
		var input_values = input_movement(250, true)
		collision.global_position.x = input_values[0]
		facing_left = input_values[1]
	elif Input.is_action_just_pressed("right"):	
		var input_values = input_movement(500, false)
		collision.global_position.x = input_values[0]
		facing_left = input_values[1]
	
	if idling:
		collision.disabled = true
		
	update_animations()
		
	
func update_animations():
	if not idling:
		if facing_left and standing_up:
			player_animations.play("up_poised")
			player_sprite.scale.x = sprite_scale
		elif facing_left and not standing_up:
			player_animations.play("down_poised")
			player_sprite.scale.x = sprite_scale
		elif not facing_left and standing_up:
			player_animations.play("up_poised")
			player_sprite.scale.x = -sprite_scale
		elif not facing_left and not standing_up:
			player_animations.play("down_poised")
			player_sprite.scale.x = -sprite_scale
	else:
		player_animations.play("idle")


func input_movement(coord, state_boolean):
		idle_timer.start()
		collision.disabled = false
		idling = false
		return [coord, state_boolean]


func _on_idle_timer_timeout():
	idling = true
