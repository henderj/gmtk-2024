extends Node2D

var movement_vector: Vector2

@export var speed: float = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	movement_vector = Vector2(speed, 0).rotated(global_rotation)

func _physics_process(delta: float):
	position += movement_vector * delta
