extends Control

@onready var hurt_overlay = $hurtoverlay
@onready var texture_rect = $TextureRect
@onready var health_bar = $"Healthbar(notexture)"
@onready var deathscreen = $deathscreen

@onready var button_restart = $deathscreen/BoxContainer2/restart
@onready var button_quit = $deathscreen/BoxContainer2/quit

@onready var controlslabel = $Controlslabel


var hurt_tween : Tween

func _ready():
	pass
	button_restart.disabled = true
	button_quit.disabled = true
	deathscreen.hide()
	health_bar.show()
	controlslabel.text = "Control list
WASD - Movement
Shift - Increase speed
Space - Jump
Ctrl - Crouch
F - Punch
T - Inspect(buggy)
TAB - Hide controls"
	
	
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

func _process(_delta):
	if Input.is_action_just_pressed("ooc"):
		controlslabel.text = "Controls hidden."
		await get_tree().create_timer(10)#nonfunctional
		controlslabel.hide()


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.levelselect.tscn")

func _on_quit_pressed():
	get_tree().quit()
	
