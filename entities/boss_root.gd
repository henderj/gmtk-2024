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

var currentMoveIndex = 0

func telegraph():
	currentMoveIndex = randi_range(0, attackPatterns.size() - 1)
	sprite.texture = facialExpressions[currentMoveIndex]
	
	await get_tree().create_timer(1.0).timeout
	
	attack()

func attack():
	var pattern = attackPatterns[currentMoveIndex].instantiate()
	
	if not pattern == null:
		get_tree().current_scene.add_child(pattern)
		pattern.position = position
	
	sprite.texture = neutralExpression
	
	timer.start(randf_range(3.0, 6.0))
	
func _ready():
	timer.start(randf_range(3.0, 6.0))
	neutralExpression = sprite.texture

func TakeDamage(old: float, new: float):
	emit_signal("take_damgage", old, new)

func Die():
	emit_signal("die")
	queue_free()
	
func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)
	print("BOSS INITIALIZED")

func _process(delta):
	global_position = body.global_position
