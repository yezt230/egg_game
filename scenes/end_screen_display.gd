extends Node2D
@onready var animation_player = $Sprawled/AnimationPlayer


func _ready():
	print(animation_player)
	animation_player.play("breathing")
