class_name State extends Node

signal transition(next_state_path: String, data: Dictionary)

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
