class_name State extends Node
#
#var change_state
#var animated_sprite
#var persistent_state
#var previous_state = null
#var states = {}

signal transition(next_state_path: String, data: Dictionary)

#@onready var parent = get_parent()

#func setup(change_state, animated_sprite, persistent_state):
	#self.change_state = change_state
	#self.animated_sprite = animated_sprite
	#self.persistent_state = persistent_state

func handle_input(_event: InputEvent) -> void:
	pass


func _enter_state(previous_state_path: String, data := {}) -> void:
	pass
	
	
func _exit_state() -> void:
	pass
	
	
func _physics_update(_delta: float) -> void:
	pass
	
	
func _update_state(_delta: float) -> void:
	pass
