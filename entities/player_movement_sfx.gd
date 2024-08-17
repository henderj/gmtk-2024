extends AudioStreamPlayer

@export var max_pitch: float = 1.2
@export var min_pitch: float = 0.8

@onready var max_speed: float = get_parent().movementSpeed

func _process(delta):
	var speed = get_parent().velocity.length()
	var pitch = lerpf(min_pitch, max_pitch, speed / max_speed)
	self.pitch_scale = pitch
	
