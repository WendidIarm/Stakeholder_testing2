extends Interactable

func _on_interacted(body):
	#add
	queue_free()
	GlobalMessenger.MaskSignal.emit()
	print("Mask acquired")

func _ready():
	var Mask_Active = get_node("res://player/view_model.gd")
	#connect("MaskSignal", Mask_Active)


func _on_mask_signal():
	pass # Replace with function body.

func on_state_changed():
	pass
