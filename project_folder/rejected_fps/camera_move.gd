extends Node3D

const mouseSen = 0.1 #Mouse sensitivity

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #Will trap the mouse cursor inside the game window

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouseSen))
		$Camera.rotate_x(deg_to_rad(-event.relative.y * mouseSen))
		rotation.y = clamp(rotation.y, deg_to_rad(-89), deg_to_rad(89))
		$Camera.rotation.x = clamp($Camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	#Code adapted from YoutTube video called "How To Code An FPS Controller In Godot 3" by Nagi
	#                       https://youtu.be/jf_Hz0diI8Y

func _physics_process(delta):
	if Input.is_action_just_pressed("toggle_fs"):
		#OS.set_window_fullscreen(!OS.window_fullscreen) #The godot 3 version
		#WINDOW_MODE_FULLSCREEN is 3. See docs for specific numbers
		if DisplayServer.window_get_mode() == 3: #If fullscreen
			DisplayServer.window_set_mode(0)     #Set to windowed
		else:                                    #If not fullscreen
			DisplayServer.window_set_mode(3)     #Set to fullscreen
