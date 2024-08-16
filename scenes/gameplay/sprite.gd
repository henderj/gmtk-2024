extends Sprite2D

#var velocity = Vector2(0,0)
#var dir = Vector2(0,0)
#
#@export var movementSpeed = 300 
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#
#func _physics_process(delta):
	#dir = Vector2(0, 0)
#
	#if Input.is_key_pressed(KEY_D):
		## Move as long as the key/button is pressed.
		#dir.x += 1
	#if Input.is_key_pressed(KEY_A):
		## Move as long as the key/button is pressed.
		#dir.x -= 1
	#if Input.is_key_pressed(KEY_W):
		## Move as long as the key/button is pressed.
		#dir.y -= 1
	#if Input.is_key_pressed(KEY_S):
		## Move as long as the key/button is pressed.
		#dir.y += 1
	#
	#dir = dir.normalized() * movementSpeed
	#velocity = velocity.lerp(dir, 6 * delta)
#
	#move_and_slide()
