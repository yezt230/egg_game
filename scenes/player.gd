extends CharacterBody2D



@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var idle_timer = $IdleTimer

@onready var facing_left = false
@onready var facing_right = false
@onready var standing_up = false
@onready var lying_down = false
@onready var idling = true
@onready var sprite_scale = 0.5

func _ready():
	player_animations.play("idle")


func _process(delta):	
	if Input.is_action_just_pressed("up"):
		standing_up = true
		lying_down = false
		idle_timer.start()
	elif Input.is_action_just_pressed("down"):
		standing_up = false
		lying_down = true
		idle_timer.start()
	if Input.is_action_just_pressed("left"):
		facing_left = true
		facing_right = false
		idle_timer.start()
	elif Input.is_action_just_pressed("right"):
		facing_left = false
		facing_right = true
		idle_timer.start()
	
	update_animations()
	
	
func update_animations():
	if facing_left and standing_up:
		player_animations.play("up_poised")
		player_sprite.scale.x = sprite_scale
	elif facing_left and lying_down:
		player_animations.play("down_poised")
		player_sprite.scale.x = sprite_scale
	elif facing_right and standing_up:
		player_animations.play("up_poised")
		player_sprite.scale.x = -sprite_scale
	elif facing_right and lying_down:
		player_animations.play("down_poised")
		player_sprite.scale.x = -sprite_scale
	
		#if Input.is_action_just_pressed("left"):
			#player_animations.play("up_poised")
	#elif Input.is_action_just_pressed("down"):
		#if Input.is_action_just_pressed("left"):
			#player_animations.play("down_poised")


func _on_idle_timer_timeout():
	print("timer")
	player_animations.play("idle")
	#pass # Replace with function body.
