extends ShootingPattern

@export var num_bullets: int = 10

var num_shot: int = 0

func on_shoot():
	num_shot += 1
	if num_shot >= num_bullets:
		done.emit()
		queue_free()
