extends CharacterBody2D

signal initialize(max: float, val: float, color: Color)
signal take_damage(old: float, new: float)

var dir = Vector2(0,0)
var is_shooting: bool = false

@export var movementSpeed = 300
@export var shootingSlowDown: float = 0.5
@export var invincibility_time: float = 0.5

@onready var shooter: Shooter = $Sprites/ArmOrigin/Arm/Shooter
@onready var shooter_timer: Timer = $Sprites/ArmOrigin/Arm/Timer
@onready var health: HealthComponent = $HealthComponent
@onready var particleEmitter: GPUParticles2D = $GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	shooter_timer.paused = true

func TakeDamage(old: float, new: float):
	take_damage.emit(old, new)
	health.invincible = true
	$Sprites.do_blink(invincibility_time)
	particleEmitter.emitting = true
	await get_tree().create_timer(invincibility_time).timeout
	health.invincible = false

func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)

func _process(delta):
	if Input.is_action_just_pressed('fire'):
		is_shooting = true
	if Input.is_action_just_released('fire'):
		is_shooting = false
	shooter_timer.paused = not is_shooting

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
	if is_shooting:
		dir *= shootingSlowDown
	velocity = velocity.lerp(dir, 6 * delta)

	move_and_slide()
