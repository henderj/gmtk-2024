extends Node2D

signal take_damgage(old_amount: float, new_amount: float)
signal die
signal initialize(max: float, val: float, color: Color)

@onready var body = $AnimatableBody2D
@onready var timer = $Timer
@onready var sprite = $AnimatableBody2D/Sprite2D


@export var attackPatterns: Array[PackedScene] = []
@export var facialExpressions: Array[Texture2D] = []
@export var neutralExpression: Texture2D
@export var dyingExpression: Texture2D
@export var touch_damage: float = 1
@export var touch_knockback: float = 500

@export var playerNode: Node2D

var currentMoveIndex = 0
var isDead = false

func telegraph():
	
	if playerNode == null:
		return
	
	currentMoveIndex = randi_range(0, attackPatterns.size() - 1)
	sprite.texture = facialExpressions[currentMoveIndex]
	
	await get_tree().create_timer(1.0).timeout
	if not isDead:
		attack()
	
	await get_tree().create_timer(1.0).timeout
	if not isDead:
		body.Move()	

func attack():
	var pattern = attackPatterns[currentMoveIndex].instantiate()
	
	if not pattern == null:
		get_tree().current_scene.add_child(pattern)
		pattern.position = position
		pattern.rotation = get_angle_to(playerNode.position)
	
	sprite.texture = neutralExpression
	
	timer.start(randf_range(3.0, 6.0))
	
func _ready():
	timer.start()
	neutralExpression = sprite.texture

func TakeDamage(old: float, new: float):
	emit_signal("take_damgage", old, new)

func Die():
	emit_signal("die")
	sprite.texture = dyingExpression
	isDead = true
	
	body.Stop()
	timer.stop()
	
func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)
	print("BOSS INITIALIZED")

func _process(delta):
	global_position = body.global_position


func on_hit(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		var knockback_dir = hitbox.global_position - global_position
		var knockback = knockback_dir.normalized() * touch_knockback
		hitbox.damage(touch_damage, knockback)
