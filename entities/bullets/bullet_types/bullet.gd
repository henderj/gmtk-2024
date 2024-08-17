extends Area2D
class_name Bullet

@export var damage_amount: float = 1
@export var life_span: float = 10
@export var shoot_sound: String = 'laser_fire'
@export var hit_sound: String = 'laser_hit'

func _ready():
	SoundManager.PlaySound(shoot_sound)
	$SelfDestruct.timeout.connect(queue_free)
	$SelfDestruct.start(life_span)

func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(damage_amount)
		SoundManager.PlaySound(hit_sound)
		queue_free()
