extends Control



func _on_playtest_pressed():
	get_tree().change_scene_to_file("res://levels(heavyquotes)/Maingame1.tscn")



func _on_back_pressed():
	pass # Replace with function body. 
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_mainlevel_pressed():
	get_tree().change_scene_to_file("res://levels(heavyquotes)/Level1.tscn")
