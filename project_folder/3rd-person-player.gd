extends CharacterBody3D

#Borrows from youtube videos
#https://youtu.be/AW3rT-7J8ag
#https://youtu.be/jf_Hz0diI8Y

const SPEED = 5.0
const ACCEL = 10.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.1 #Mouse sensitivity
const GRAVITY = 7.0

var move_dir = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #Will trap the mouse cursor inside the game window

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
		$SpringArm3D.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))
		#rotation.y = clamp(rotation.y, deg_to_rad(-89), deg_to_rad(89))
		$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	if Input.is_action_just_pressed("Input_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_dir = Vector3(
		Input.get_axis("Input_A", "Input_D"),
		0,
		Input.get_axis("Input_W", "Input_S")
	).normalized().rotated(Vector3.UP, rotation.y)
	
	velocity.x = lerp(velocity.x, move_dir.x * SPEED, ACCEL * delta)
	velocity.z = lerp(velocity.z, move_dir.z * SPEED, ACCEL * delta)

	move_and_slide()
