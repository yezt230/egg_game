extends AudioStreamPlayer


func _ready():
	finished.connect(_on_finished)
	
	if not $Timer.timeout.is_connected(_on_timer_timeout):
		$Timer.timeout.connect(_on_timer_timeout)


func _on_finished():
	MusicPlayer.pitch_scale = 0.85
	$Timer.start()
	

func _on_timer_timeout():
	play()
