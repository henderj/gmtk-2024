extends ShootingPattern

@export var num_bullets: int = 20
@export var rate: float = 0.15
@export var rotation_amount: float = 22.5

var num_shot: int = 0

@onready var timer = $Timer
@onready var rotation_rads = deg_to_rad(rotation_amount)

func _ready():
	for child in $Circle.get_children():
		timer.timeout.connect(child.shoot)
	timer.timeout.connect(on_shoot)
	timer.start(rate)

func on_shoot():
	$Circle.rotate(rotation_rads)
	num_shot += 1
	if num_shot >= num_bullets:
		queue_free()
