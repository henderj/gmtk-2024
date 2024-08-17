extends Node2D

signal take_damgage(old_amount: float, new_amount: float)
signal die
signal initialize(max: float, val: float, color: Color)

@onready var body = $AnimatableBody2D

func TakeDamage(old: float, new: float):
	emit_signal("take_damgage", old, new)

func Die():
	emit_signal("die")
	
func _initializeHealthBar(max: float, val: float, color: Color):
	initialize.emit(max, val, color)
	print("BOSS INITIALIZED")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = body.global_position


func _on_health_component_initialize(max, val, color):
	pass # Replace with function body.
