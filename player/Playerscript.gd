extends CharacterBody3D

var sensitivity = 0.004

@export var speed = 5.0
@export var accel = 16.0
@export var jumpvelo = 6.2
@export var run_speed = 1.27


@export var crouch_speed = 4.0
@export var crouch_height = 2.0
@export var crouch_transition = 8.0
@export var falldmg_threshold = 20


var stand_height : float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var old_vel : float = 0.0
var hurt_tween : Tween

var live = true #TESTING
var mask_on = false

@onready var neck := $neck #establishing connection to the head/neck node
@onready var camera := $neck/Camera3D #establishing connection to the camera
@onready var collision_shape = $CollisionShape3D
@onready var top_cast = $"../Topcast"
@onready var view_model_camera = $neck/Camera3D/SubViewportContainer/SubViewport/view_model_camera

var explosion_preload = preload("res://player/other/knockbacksphere.tscn")

func _ready():
	stand_height = collision_shape.shape.height
	$neck/Camera3D/SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()
	GlobalMessenger.connect("MaskSignal", Mask_Active)


func _process(_delta):
	pass

func _unhandled_input(event): #First person mouse control
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #capturing the mouse button for the camera to track
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #Removes the mouse lock, temperary until mini menu is made
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * sensitivity) #Below
			camera.rotate_x(-event.relative.y * sensitivity) #sensitivity for the camera, could be changed to a slider in minimenu
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-85), deg_to_rad(80)) #Locks neck to natural positions only
			view_model_camera.sway(Vector2(event.relative.x, event.relative.y))

func _physics_process(delta):
	$neck/Camera3D/SubViewportContainer/SubViewport/view_model_camera.global_transform = camera.global_transform
	var move_speed = speed
	
	if Input.is_action_pressed("run"): #PLEASE FIX THIS!!!!!!
		if live == true:	#print("Running")
			run()
		else:
			pass
	if Input.is_action_just_pressed("punch"):
		if mask_on == true:
			print("Attempting")
			var blowup = explosion_preload.instantiate()
			add_child(blowup)
			blowup.global_transform.origin = global_transform.origin
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	elif live:
		if Input.is_action_pressed("jump"):
			#print("Jumping")
			velocity.y = jumpvelo
		elif Input.is_action_pressed("crouch"): #crouch rules
			print("Crouching")
			move_speed = crouch_speed
			crouch(delta)
			
			if Input.is_action_pressed("run"):
				slide()
		else:
			crouch(delta, true)


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. - so true
	if live == true:
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = lerp(velocity.x, direction.x * move_speed, accel * delta)
			velocity.z = lerp(velocity.z, direction.z * move_speed, accel * delta)
		else:
			velocity.x = lerp(velocity.x, 0.0, accel * delta)
			velocity.z = lerp(velocity.z, 0.0, accel * delta)

	move_and_slide()


	if old_vel < 0: #Fall damage indicator
		var diff = velocity.y - old_vel
		if diff > falldmg_threshold:
			hurt(diff - falldmg_threshold + 10)
			crouch(delta)
			print("FALL DAMAGE TAKEN")
	old_vel = velocity.y


func crouch(delta : float, reverse = false): #player camera change on crouch
	var target_height : float = crouch_height if not reverse else stand_height
	
	collision_shape.shape.height = target_height
	collision_shape.position.y = target_height * 0.5
	camera.position.y = lerp(camera.position.y, target_height - 1, crouch_transition * delta)

func run():
	velocity.x *= run_speed
	velocity.z *= run_speed



func slide(): #please for the love of god do not keep this
	print("You should be sliding")

var fall_distance = 0
var slide_speed = 0
var can_slide = false
var sliding = false
var falling = false

#UI Jail
@onready var hurt_overlay = $"../UI/hurtoverlay"
@onready var health_bar = $"../UI/Healthbar(notexture)"
@onready var ui = $"../UI"


func hurt(damage : float): #hurt animation
	ui.hurt(damage)
	
	if health_bar.value <= 0:
		die()

func die():
	live = false
	ui.show_deathscreen()

var knockback_resistance = 3
#var extravel := Vector3.ZERO
#var ySpeed := 0.0


func knockback(k: Knockback):
	print("AAAAAAAAAAAAAA")
	velocity += (global_transform.origin - k.knockback_origin).normalized() * k.knockback_force
	velocity.y += k.knockback_force/knockback_resistance
#extravel, ySpeed

func Mask_Active():
	if Input.is_action_pressed("Maskon"):
		mask_on = true
	pass
#_____________________________________________________________

#func explode():
#	print("BANG")
#	if Input.is_action_pressed("punch"):
#		print("Attempting")
#		var blowup = explosion_preload.instantiate()
#		add_child(blowup)
#		blowup.global_transform.origin = global_transform.origin
		
	
