extends Area2D
class_name Bullet

@export var damage_amount: float
@export var speed: float = 500
@export var life_span: float = 3

var movement_vector: Vector2

func _ready():
	$SelfDestruct.timeout.connect(queue_free)
	$SelfDestruct.start(life_span)
	movement_vector = Vector2(speed, 0).rotated(global_rotation)

func _process(delta: float):
	position += movement_vector * delta

func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(damage_amount)
		queue_free()
