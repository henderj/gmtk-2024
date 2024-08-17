extends BulletMovement

var movement_vector: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	movement_vector = Vector2(speed, 0).rotated(parent.global_rotation)

func _physics_process(delta: float):
	parent.position += movement_vector * delta
