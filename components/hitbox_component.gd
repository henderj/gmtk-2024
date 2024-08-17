extends Area2D
class_name HitboxComponent

signal hit(amount: float, knockback: Vector2)

@export var health_component: HealthComponent

func damage(amount: float, knockback: Vector2):
	hit.emit(amount, knockback)
	if health_component:
		health_component.damage(amount)
