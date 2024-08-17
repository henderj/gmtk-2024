extends Area2D
class_name Bullet

@export var damage_amount: float = 1
@export var knockback_amount: float = 300
@export var life_span: float = 10
@export var hit_sound: String = 'laser_hit'

func _ready():
	$SelfDestruct.timeout.connect(queue_free)
	$SelfDestruct.start(life_span)

func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		var knockback_dir = hitbox.global_position - global_position
		var knockback = knockback_dir.normalized() * knockback_amount
		hitbox.damage(damage_amount, knockback)
		SoundManager.PlaySound(hit_sound)
		queue_free()
