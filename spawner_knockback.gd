extends Node3D

var explosion_preload = preload("res://player/other/knockbacksphere.tscn")



#func _on_spawn_timer_timeout():
#	print("Trying")
#	var blowup = explosion_preload.instantiate()
#	add_child(blowup)
#	blowup.global_transform.origin = global_transform.origin
	
func _on_spawn_timer_timeout():
	print("Trying")
	var blowup = explosion_preload.instantiate()
	add_child(blowup)
	blowup.global_transform.origin = global_transform.origin

func _ready():
	#if Input.is_action_just_pressed("punch"):
	pass
