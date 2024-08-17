extends AnimatableBody2D

var dir = Vector2(0,0)

var t = PI / 2

@export var movementSpeed = 300 

var legHips: Array[Node2D] = []
var legOrginalRotations: Array[float] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	legHips.push_back($HitboxComponent/LegHip)
	legHips.push_back($HitboxComponent/LegHip2)
	legHips.push_back($HitboxComponent/LegHip3)
	legHips.push_back($HitboxComponent/LegHip4)
	legHips.push_back($HitboxComponent/LegHip5)
	legHips.push_back($HitboxComponent/LegHip6)
	legHips.push_back($HitboxComponent/LegHip7)
	legHips.push_back($HitboxComponent/LegHip8)
	
	legOrginalRotations.push_back(legHips[0].rotation)
	legOrginalRotations.push_back(legHips[1].rotation)
	legOrginalRotations.push_back(legHips[2].rotation)
	legOrginalRotations.push_back(legHips[3].rotation)
	legOrginalRotations.push_back(legHips[4].rotation)
	legOrginalRotations.push_back(legHips[5].rotation)
	legOrginalRotations.push_back(legHips[6].rotation)
	legOrginalRotations.push_back(legHips[7].rotation)

func _animateLegs(dir: Vector2):
	
	for i in 8:
		var offset = dir.x * .4
		legHips[i].rotation = legOrginalRotations[i] + offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	t += delta
	
	
	dir = Vector2(sin(t), 0)
	
	position += dir * movementSpeed
	
	_animateLegs(dir)
