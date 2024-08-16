extends Area2D
class_name Bullet

@export var damage_amount: float
@export var life_span: float = 3


func _ready():
	$SelfDestruct.timeout.connect(queue_free)
	$SelfDestruct.start(life_span)


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(damage_amount)
		queue_free()
