extends Node2D
@onready var animation_player = $Sprawled/AnimationPlayer


func _ready():
	animation_player.play("breathing")
	MusicPlayer.pitch_scale = 0.775
