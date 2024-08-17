extends Node2D

@export var max_head_tilt: float = 5
@export var mid_head_tilt: float = 0
@export var min_head_tilt: float = -20

@onready var max_head_tilt_rads = deg_to_rad(max_head_tilt)
@onready var mid_head_tilt_rads = deg_to_rad(mid_head_tilt)
@onready var min_head_tilt_rads = deg_to_rad(min_head_tilt)

@onready var originalScale: Vector2 = scale

#@onready var leg_left = $LegLeft
#@onready var leg_left_anchor = $LegLeftAnchor
#@onready var leg_right = $LegRight
#@onready var leg_right_anchor = $LegRightAnchor

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var angle_to_mouse = global_position.angle_to_point(mouse_pos)
	$ArmOrigin.global_rotation = angle_to_mouse
	
	$HeadOrigin.rotation = calc_head_tilt(angle_to_mouse)
	
	#leg_left.global_position = leg_left.global_position.lerp(leg_left_anchor.global_position, delta)
	
	var x_scale = originalScale.x
	if mouse_pos.x < global_position.x:
		x_scale = -originalScale.x
	self.scale = Vector2(x_scale, originalScale.y)

func calc_head_tilt(angle: float) -> float:
	if angle > 0 and angle <= PI / 2: # bottom right
		return lerpf(mid_head_tilt_rads, min_head_tilt_rads, angle / (PI / 2))
	if angle > PI / 2: # bottom left
		return lerpf(min_head_tilt_rads, mid_head_tilt_rads, (angle - PI / 2 ) / (PI / 2))
	if angle < 0 and angle >= -PI / 2: # top right:
		return lerpf(mid_head_tilt_rads, max_head_tilt_rads, angle / (-PI / 2))
	else: # angle < -PI / 2: # top left
		return lerpf(max_head_tilt_rads, mid_head_tilt_rads, (angle + PI / 2) / (-PI / 2))
