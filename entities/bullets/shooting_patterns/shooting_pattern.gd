extends Node
class_name ShootingPattern

signal done

@export var num_bullets: int = 20
@export var rate: float = 0.15
@export var shoot_sound: String = 'laser_fire'

var num_shot: int = 0

func _ready():
	var timer = $Timer
	var shooters = $Shooters
	for child in shooters.get_children():
		timer.timeout.connect(child.shoot)
	timer.timeout.connect(on_shoot)
	timer.start(rate)

func on_shoot():
	SoundManager.PlaySound(shoot_sound)
	num_shot += 1
	if num_shot >= num_bullets:
		done.emit()
		queue_free()
