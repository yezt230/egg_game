extends AudioStreamPlayer2D

@export var SoundArray: Array[AudioStream]

func play_gulp():
	if SoundArray == null || SoundArray.size() == 0:
		return
	
	var will_play_gulp_sound = randi() % 3
	if will_play_gulp_sound == 0:
		stream = SoundArray.pick_random()
		play()

	
