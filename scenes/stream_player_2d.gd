extends AudioStreamPlayer2D

@export var SoundArray: Array[AudioStream]

func play_belch():
	if SoundArray == null || SoundArray.size() == 0:
		return
	
	stream = SoundArray.pick_random()
	play()

	
