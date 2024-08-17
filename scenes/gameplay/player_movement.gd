extends CharacterBody2D

signal initialize(max: float, val: float, color: Color)
signal take_damage(old: float, new: float)

var dir = Vector2(0,0)

@export var movementSpeed = 300 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func TakeDamage(old: float, new: float):
	take_damage.emit(old, new)

func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)

func _physics_process(delta):
	dir = Vector2(0, 0)

	if Input.is_key_pressed(KEY_D):
		# Move as long as the key/button is pressed.
		dir.x += 1
	if Input.is_key_pressed(KEY_A):
		# Move as long as the key/button is pressed.
		dir.x -= 1
	if Input.is_key_pressed(KEY_W):
		# Move as long as the key/button is pressed.
		dir.y -= 1
	if Input.is_key_pressed(KEY_S):
		# Move as long as the key/button is pressed.
		dir.y += 1
	
	dir = dir.normalized() * movementSpeed
	velocity = velocity.lerp(dir, 6 * delta)

	move_and_slide()
