extends ShootingPattern

@export var num_bullets: int = 20
@export var rate: float = 0.15

var num_shot: int = 0

@onready var timer = $Timer

func _ready():
	for child in $Shooters.get_children():
		timer.timeout.connect(child.shoot)
	timer.timeout.connect(on_shoot)
	timer.start(rate)

func on_shoot():
	num_shot += 1
	if num_shot >= num_bullets:
		done.emit()
		queue_free()
