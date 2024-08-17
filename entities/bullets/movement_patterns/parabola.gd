extends BulletMovement

@export var a: float = 0.003
@export var b: float = -100
@export var inverse: bool

var c: float
var time: float = 0
var pos_offset: Vector2
var rot: float

func _ready():
	rot = global_rotation
	pos_offset = global_position
	c = sqrt(-b/a)
	if inverse:
		a *= -1
		b *= -1

func calc_pos(t: float) -> Vector2:
	var x = t
	var y = a * pow((t - c), 2) + b
	return Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = calc_pos(time)
	pos = pos.rotated(rot)
	parent.global_position = pos_offset + pos
	time += delta * speed
