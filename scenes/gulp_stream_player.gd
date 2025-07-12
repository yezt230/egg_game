extends AudioStreamPlayer2D

@export var SoundArray: Array[AudioStream]
@onready var gulp_timer = $GulpSoundPauseTimer
@onready var can_play_gulp_sound_timer = true
var already_played_in_animation = false

func play_gulp():
	if already_played_in_animation:
		return
	
	if SoundArray == null || SoundArray.size() == 0:
		return
	
	var will_play_gulp_sound = randi() % 1
	if will_play_gulp_sound == 0 and can_play_gulp_sound_timer:
	#if will_play_gulp_sound == 0:
		can_play_gulp_sound_timer = false
		already_played_in_animation = true
		gulp_timer.start()
		stream = SoundArray.pick_random()
		play()


func _on_gulp_sound_pause_timer_timeout():
	can_play_gulp_sound_timer = true
	already_played_in_animation = false
