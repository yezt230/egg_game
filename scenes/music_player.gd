extends AudioStreamPlayer


func _ready():
	finished.connect(_on_finished)
	
	if not $Timer.timeout.is_connected(_on_timer_timeout):
		$Timer.timeout.connect(_on_timer_timeout)


func _on_finished():
	$Timer.start()
	

func _on_timer_timeout():
	play()
