extends AnimatableBody2D

var dir = Vector2(0,0)

var t = PI / 2

@export var movementSpeed = 1000
@export var minMovement: float = 400
@export var maxMovement: float = 1000

var legHips: Array[Node2D] = []
var legOrginalRotations: Array[float] = []

var movePoint: Vector2 = Vector2.ZERO

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


func Move():
	
	var upperLeftBound = Vector2(200, 200)
	var lowerRightBound = Vector2(1920 - 200, 1080 - 200)
	
	movePoint = Vector2.ZERO
	
	while position.distance_to(movePoint) < minMovement or position.distance_to(movePoint) > maxMovement:
	
		movePoint = Vector2(
			randi_range(upperLeftBound.x, lowerRightBound.x),
			randi_range(upperLeftBound.y, lowerRightBound.y))

func Stop():
	movePoint = Vector2.ZERO
	

func _physics_process(delta):
	
	if (movePoint != Vector2.ZERO):
		
		dir = global_position.direction_to(movePoint)
		
		position += dir * movementSpeed * delta
		
		
		if global_position.distance_to(movePoint) <= 10:
			movePoint = Vector2.ZERO
			dir = Vector2.ZERO

		_animateLegs(dir)
