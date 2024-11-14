extends CharacterBody2D



@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var idle_timer = $IdleTimer

@onready var facing_left = false
@onready var standing_up = false
@onready var idling = true
@onready var sprite_scale = 0.5

func _ready():
	player_animations.play("idle")


func _process(delta):	
	if Input.is_action_just_pressed("up"):
		standing_up = true
		idle_timer.start()
		collision.global_position.y = 300
	elif Input.is_action_just_pressed("down"):
		standing_up = false
		idle_timer.start()
		collision.global_position.y = 450
	if Input.is_action_just_pressed("left"):
		facing_left = true
		idle_timer.start()
		collision.global_position.x = 250
	elif Input.is_action_just_pressed("right"):
		facing_left = false
		idle_timer.start()
		collision.global_position.x = 500
	
	update_animations()
	
	
func update_animations():
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


func _on_idle_timer_timeout():
	#print("timer")
	player_animations.play("idle")
	#pass # Replace with function body.
