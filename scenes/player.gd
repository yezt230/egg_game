class_name Player extends CharacterBody2D

@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var idle_timer = $IdleTimer
@onready var state_label = $StateLabel
@onready var state_machine = $StateMachine

@onready var sprite_scale = 0.45
@onready var burp_counter = 0

func _ready():
	state_machine.init(self)
	player_sprite.scale.x = sprite_scale
	player_sprite.scale.y = sprite_scale
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
	var current_state_name = state_machine.get_current_state()
	state_label.text = current_state_name
	

func input_movement(coord, state_boolean):
		#collision.disabled = false
		#idling = false
		return [coord, state_boolean]


func connect_enemy_signal(enemy):
	enemy.connect("enemy_eaten", Callable(self, "_on_enemy_eaten"))


func _on_enemy_eaten():
	state_machine.on_enemy_eaten()


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
