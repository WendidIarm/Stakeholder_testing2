extends RigidBody3D

var targets = []

@export var knockback_force: float


func _on_area_3d_body_entered(body):
	targets.append(body)
	print("I see")


func _on_area_3d_body_exited(body):
	targets.erase(body)
	print("I do not see")


func _on_delay_timeout():
	var k = Knockback.new()
	k.knockback_force = knockback_force
	k.knockback_origin = global_transform.origin
	knockback_bodies(k)

func knockback_bodies(k: Knockback):
	for target in targets:
		if target.has_method("knockback"): #What is the "" bit please
			print("attempting push")
			target.knockback(k)
