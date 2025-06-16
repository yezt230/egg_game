class_name Player extends CharacterBody2D

@onready var player_sprite = $Sprite2D
@onready var player_animations = $Sprite2D/AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var idle_timer = $IdleTimer
@onready var state_label = $StateLabel
@onready var state_machine = $StateMachine
@onready var belch_label = $BelchLabel
@onready var burp_label = $BurpLabel

@onready var sprite_scale = 1.0
@onready var burp_queued = false

# reserved_state is only used for recording up/down
# state for reverted to after belching
# 0 = standing, 1 = crouching
var reserved_state: String = "idle"
var burp_counter: int = 0

var collision_coords = {
	top = 330,
	bottom = 490,
	left = 510,
	right = 240,
	idle_x = 400,
	idle_y = 25
}
var current_swallow_progress: float = 0.0

func _ready():
	state_machine.init(self)
	player_sprite.scale.x = sprite_scale
	player_sprite.scale.y = sprite_scale
	# Probably a better way to do this than using a new signal inside the player
	# code to check when a new enemy spawns
	get_tree().connect("node_added",  Callable(self, "_on_node_added"))
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		connect_enemy_signal(enemy)


func _on_node_added(new_node):
	if new_node.is_in_group("Enemies"):
		connect_enemy_signal(new_node)


#More optimal way to assign multiple values at once?
func _process(_delta):
	var current_state_name = state_machine.get_current_state()
	state_label.text = current_state_name
	belch_label.text = str(burp_queued)
	#burp_label.text = str(burp_counter)
	burp_label.text = str(reserved_state)

func input_movement(coord, state_boolean):
	return [coord, state_boolean]


func connect_enemy_signal(enemy):
	enemy.connect("enemy_eaten", Callable(self, "_on_enemy_eaten").bind(enemy))


func _on_enemy_eaten(enemy):
	if enemy.belch_initiator:
		burp_queued = true
	state_machine.on_enemy_eaten()


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
