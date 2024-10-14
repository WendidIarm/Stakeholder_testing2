extends Camera3D

@onready var animation_player = $Telomere_ARMSonly/AnimationPlayer #CHANGE AFTER ANIMATION UPDATES
@onready var telomere_arm = $Telomere_ARMSonly
@onready var animation_tree = $Telomere_ARMSonly/AnimationTree

var Noitem = true
var Maskgot = false
var Maskinuse = false
var GHookinuse = false
var Healinginuse = false

func _ready():
	GlobalMessenger.connect("MaskSignal", Mask_Active)


func _process(delta):
	update_animation_parametres()
	telomere_arm.position.x = lerp(telomere_arm.position.x,0.0,delta*5)
	telomere_arm.position.x = lerp(telomere_arm.position.x,0.0,delta*5)

func sway(sway_amount):
	pass
	telomere_arm.position.x -= sway_amount.x*0.0008
	telomere_arm.position.y += sway_amount.y*0.0008
	telomere_arm.position.x = clamp(telomere_arm.position.x, deg_to_rad(0), deg_to_rad(0))#Change this is pointless code
#Don't animate walking if crouching DUH

func update_animation_parametres():
	if Noitem == true:
		if(Input.is_action_pressed("movement")==false):
			animation_tree["parameters/conditions/idle"] = true
			animation_tree["parameters/conditions/is_moving"] = false
		else:
			if(Input.is_action_pressed("crouch")==true):
				animation_tree["parameters/conditions/idle"] = true
				animation_tree["parameters/conditions/is_moving"] = false
			else:
				animation_tree["parameters/conditions/idle"] = false
				animation_tree["parameters/conditions/is_moving"] = true
	
		if Input.is_action_just_pressed("weaponinsp"):
			animation_tree["parameters/conditions/inspect1"] = true
			print("Hand inspecting")
		else:
			animation_tree["parameters/conditions/inspect1"] = false
	
		if Input.is_action_just_pressed("punch"):
			animation_tree["parameters/conditions/punch"] = true
		else:
			animation_tree["parameters/conditions/punch"] = false
	if Maskgot == true:
		if Input.is_action_just_pressed("Maskon"):
			animation_tree["parameters/conditions/mask_on"] = true
			print("maskon")
		else:
			animation_tree["parameters/conditions/mask_on"] = false

		if(Input.is_action_pressed("movement")==false):
			animation_tree["parameters/conditions/idle.mask"] = true
			animation_tree["parameters/conditions/is_moving.mask"] = false
		else:
			if(Input.is_action_pressed("crouch")==true):#Don't animate walking if crouching DUH
				animation_tree["parameters/conditions/idle.mask"] = true
				animation_tree["parameters/conditions/is_moving.mask"] = false
			else:
				animation_tree["parameters/conditions/idle.mask"] = false
				animation_tree["parameters/conditions/is_moving.mask"] = true
	
		if Input.is_action_just_pressed("weaponinsp"):
			animation_tree["parameters/conditions/inspect2"] = true
			print("Hand inspecting")
		else:
			animation_tree["parameters/conditions/inspect2"] = false
	
		#if Input.is_action_just_pressed("punch"):
		#	animation_tree["parameters/conditions/mask_on"] = true
		#	print("Punch")
		#else:
		#	animation_tree["parameters/conditions/mask_on"] = false

func Mask_change():
	pass

func Mask_Active():
	print("Successful")
	Maskgot = true
	if Input.is_action_just_pressed("Maskon"):
		Maskinuse = true
	
