extends ShootingPattern

@export var num_bullets: int = 10
@export var rate: float = 0.25

var num_shot: int = 0

@onready var timer1 = $Timer1
@onready var timer2 = $Timer2

func _ready():
	for child in $Circle1.get_children():
		timer1.timeout.connect(child.shoot)
	for child in $Circle2.get_children():
		timer2.timeout.connect(child.shoot)
	timer1.timeout.connect(on_shoot)
	timer2.timeout.connect(on_shoot)
	timer1.start(rate * 2)
	await get_tree().create_timer(rate).timeout
	timer2.start(rate * 2)

func on_shoot():
	num_shot += 1
	if num_shot >= num_bullets:
		queue_free()
