extends Area2D


func _ready():
	print("enemy spawned")
	area_entered.connect(_on_body_entered)
	
	
func on_area_entered():
	print("struck")


func _on_area_2d_area_entered(area):
	print("hit enemy")


func _on_body_entered(body):
	print("hella hit)")
