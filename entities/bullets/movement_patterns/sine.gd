extends BulletMovement

@export var amplitude: float = 100
@export var period: float = 400
@export var inverse: bool

var time: float = 0
var pos_offset: Vector2
var rot: float

func _ready():
	rot = global_rotation
	pos_offset = global_position
	if inverse:
		amplitude *= -1

func calc_pos(t: float) -> Vector2:
	var x = t
	var y = amplitude * sin((2 * PI * x) / period)
	return Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = calc_pos(time)
	pos = pos.rotated(rot)
	parent.global_position = pos_offset + pos
	time += delta * speed
