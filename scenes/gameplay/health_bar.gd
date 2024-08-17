extends ProgressBar

@export var shake_amount: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func InitializeHealthbar(max: float, val: float,  color: Color):
	print("HEALTHBAR INITIALIZED")
	max_value = max
	value = val
	modulate = color
	

func ChangeValue(old: float, new: float):
	value = new
	$AnimationPlayer.play("shake")
	
