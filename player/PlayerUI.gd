extends Control

@onready var hurt_overlay = $hurtoverlay
@onready var texture_rect = $TextureRect
@onready var health_bar = $"Healthbar(notexture)"
@onready var deathscreen = $deathscreen

@onready var button_restart = $deathscreen/BoxContainer2/restart
@onready var button_quit = $deathscreen/BoxContainer2/quit

@onready var controlslabel = $Controlslabel
@onready var questionprompt = $Areyousure
@onready var timer = $Timer

#When the controls are displayed, Tabremoved = 0, when they are hidden it equals 1
var tab_removed = 0

var hurt_tween : Tween

func _ready():
	pass
	button_restart.disabled = true
	button_quit.disabled = true
	deathscreen.hide()
	questionprompt.text = ""
	health_bar.show()
	controlslabel.text = "Control list
WASD - Movement
Shift - Increase speed
Space - Jump
Ctrl - Crouch
F - Punch
T - Inspect(buggy)
TAB - Hide controls
B - Self destruct"
	
	
func hurt(damage : float): #hurt animation
	health_bar.value -= damage
	hurt_overlay.modulate = Color.WHITE
	if hurt_tween:
		hurt_tween.kill()
	hurt_tween = create_tween()
	hurt_tween.tween_property(hurt_overlay, "modulate", Color.TRANSPARENT, 1.7)

func show_deathscreen():
	button_restart.disabled = false
	button_quit.disabled = false
	deathscreen.show()
	health_bar.hide()
	Control.MOUSE_FILTER_STOP #change

#Control tab hide code
func _process(_delta):	
	if Input.is_action_just_pressed("restart"):
		questionprompt.text = "Are you sure?"
		print("check1")
		if Input.is_action_just_pressed("restart"):#  -----!!!!!!!!!!!!!PROBLEM LINE!!!!!!!
			print("check2")
			var _reload = get_tree().reload_current_scene()

	if tab_removed == 1:
		controlslabel.text = "Controls hidden"

	if Input.is_action_just_pressed("ooc"):
		if tab_removed == 0:
			controlslabel.text = "Controls hidden."
			$Timer.start(0.5)
			#await get_tree().create_timer(10)#nonfunctional
			tab_removed = 1
		if tab_removed == 1:
			tab_removed = 0
			controlslabel.text = "Control list
			WASD - Movement
			Shift - Increase speed
			Space - Jump
			Ctrl - Crouch
			F - Punch
			T - Inspect(buggy)
			TAB - Hide controls
			B - Self destruct"
	
	
	if Input.is_action_just_pressed("debug call"):
		print(tab_removed)

func _on_timer_timeout():
	controlslabel.hide()
	tab_removed = 1
	
		#if Input.is_action_just_pressed("restart"):
		#questionprompt.text = "Are you sure?
		#[V] restart [N] Menu"
		#print("check1")
		#if Input.is_action_just_pressed("v action"):
		#	print("check2")
		#	var _reload = get_tree().reload_current_scene()
		#	
		#if Input.is_action_just_pressed("n action"):
		#	print("check3")
		#	get_tree().change_scene_to_file("res://Menu/menu.levelselect.tscn")
	
	

#Death screen button links
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.levelselect.tscn")
func _on_quit_pressed():
	get_tree().quit()
	
func self_destruct():
	pass
		#WORK ON THIS TMR



