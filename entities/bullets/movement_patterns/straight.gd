extends BulletMovement

@export var speed: float = 500

var movement_vector: Vector2

@onready var parent: Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	movement_vector = Vector2(speed, 0).rotated(parent.global_rotation)

func _physics_process(delta: float):
	parent.position += movement_vector * delta
