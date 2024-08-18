extends CharacterBody2D

signal initialize(max: float, val: float, color: Color)
signal take_damage(old: float, new: float)

signal hit_boss

var dir = Vector2(0,0)
var is_shooting: bool = false

var is_transforming: bool = false

@export var movementSpeed = 300
@export var shootingSlowDown: float = 0.5
@export var invincibility_time: float = 0.5
@export var fire_sound: String = 'laser_fire'

@export var shrinkRateMultiplier: float = 3.0

@onready var shooter: Shooter = $Sprites/ArmOrigin/Arm/Shooter
@onready var shooter_timer: Timer = $Sprites/ArmOrigin/Arm/Timer
@onready var health: HealthComponent = $HealthComponent
@onready var hitParticle: CPUParticles2D = $HitParticle
@onready var shrinkParticle: CPUParticles2D = $ShrinkingParticle

# Called when the node enters the scene tree for the first time.
func _ready():
	shooter_timer.paused = true
	
func TransformIntoBullet():
	is_transforming = true
	shrinkParticle.emitting = true
	

func _doTransformation(delta, targetScale: float):
	scale = scale.lerp(Vector2.ONE * targetScale, delta)

func TransformIntoBee():
	is_transforming = false
	await get_tree().create_timer(3).timeout
	shrinkParticle.emitting = false
	

func TakeDamage(old: float, new: float):
	take_damage.emit(old, new)
	health.invincible = true
	$Sprites.do_blink(invincibility_time)
	hitParticle.restart()
	hitParticle.emitting = true
	await get_tree().create_timer(invincibility_time).timeout
	health.invincible = false

func on_hit(damage: float, knockback: Vector2):
	print(knockback)
	velocity = knockback

func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)

func _process(delta):
	if Input.is_action_just_pressed('fire'):
		is_shooting = true
		shooter_timer.timeout.emit()
		shooter_timer.start()
	if Input.is_action_just_released('fire'):
		is_shooting = false
	shooter_timer.paused = not is_shooting
	
	if is_transforming:
		_doTransformation(delta, 0.1)
	else:
		_doTransformation(delta, 1)

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

func play_fire_sound():
	SoundManager.PlaySound(fire_sound)

func HitBoss(area: Area2D):
	print("BOSS HIT")
	hit_boss.emit()
