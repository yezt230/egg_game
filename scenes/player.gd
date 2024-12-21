class_name Player extends CharacterBody2D

@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var idle_timer = $IdleTimer

@onready var facing_left = false
@onready var standing_up = true
@onready var idling = true
@onready var sprite_scale = 0.8
@onready var not_animated = false
@onready var burp_counter = 0
@onready var burping = false
@onready var state_label = $StateLabel

enum States {idle, poised_up, poised_down, swallowing_up, stifled}
@onready var state: States = States.idle

func _ready():
	player_animations.play("idle")

#Probably a better way to do this that using a new signal inside the player
#code to check when a new enemy spawns
	get_tree().connect("node_added",  Callable(self, "_on_node_added"))
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		connect_enemy_signal(enemy)


func _on_node_added(new_node):
	# Check if the added node is in the Enemies group
	if new_node.is_in_group("Enemies"):
		connect_enemy_signal(new_node)


#More optimal way to assign multiple values at once?
#TODO: top-level collision is misaligned until player presses a lower button
func _process(delta):
	if Input.is_action_just_pressed("up"):
		var input_values = input_movement(300, true)
		collision.global_position.y = input_values[0]
		standing_up = input_values[1]
		state = States.poised_up
	elif Input.is_action_just_pressed("down"):	
		var input_values = input_movement(450, false)
		collision.global_position.y = input_values[0]
		standing_up = input_values[1]
		state = States.poised_down
	if Input.is_action_just_pressed("left"):
		var input_values = input_movement(250, true)
		collision.global_position.x = input_values[0]
		facing_left = input_values[1]
	elif Input.is_action_just_pressed("right"):	
		var input_values = input_movement(500, false)
		collision.global_position.x = input_values[0]
		facing_left = input_values[1]
	
	if burp_counter == 2:
		burping = true
	
	if idling:
		collision.disabled = true
		
	update_animations()
	
	#print(state)
	
func update_animations():
	if not idling and not not_animated:
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
	elif idling and not not_animated:
		player_animations.play("idle")
	else:
		player_animations.play("swallow_up")
		
	if burping:
		player_animations.play("stifled_burp")
		burping = false
	#else:
		#player_animations.play("idle")


func input_movement(coord, state_boolean):
		idle_timer.start()
		collision.disabled = false
		idling = false
		return [coord, state_boolean]


func _on_idle_timer_timeout():
	#idling = true
	state = States.idle


func connect_enemy_signal(enemy):
	enemy.connect("enemy_eaten", Callable(self, "_on_enemy_eaten"))


func _on_enemy_eaten():
	idling = false
	collision.disabled = true
	not_animated = true
	idle_timer.start()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swallow_up":
		collision.disabled = false
		burp_counter += 1
		#print("burp counter" + str(burp_counter))
		not_animated = false
	
	if anim_name == "stifled_burp":
		burp_counter = 0
