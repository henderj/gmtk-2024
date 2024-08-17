extends Node2D

@export var max_head_tilt: float = 5
@export var mid_head_tilt: float = 0
@export var min_head_tilt: float = -20
@export var invincibility_color: Color
@export var invincibility_flash_rate: float = 0.1

@onready var max_head_tilt_rads = deg_to_rad(max_head_tilt)
@onready var mid_head_tilt_rads = deg_to_rad(mid_head_tilt)
@onready var min_head_tilt_rads = deg_to_rad(min_head_tilt)

@onready var originalScale: Vector2 = scale

@onready var normal_color: Color = self.modulate

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var angle_to_mouse = global_position.angle_to_point(mouse_pos)
	$ArmOrigin.global_rotation = angle_to_mouse
	
	$HeadOrigin.rotation = calc_head_tilt(angle_to_mouse)
	
	var x_scale = originalScale.x
	if mouse_pos.x < global_position.x:
		x_scale = -originalScale.x
	self.scale = Vector2(x_scale, originalScale.y)

func do_blink(duration: float):
	var tween = get_tree().create_tween()
	tween.bind_node(self)
	tween.tween_property(self, 
		"modulate", 
		invincibility_color, 
		invincibility_flash_rate)
	tween.tween_property(self,
		"modulate",
		normal_color,
		invincibility_flash_rate)
	tween.set_loops()
	await get_tree().create_timer(duration).timeout
	tween.stop()
	modulate = normal_color

func calc_head_tilt(angle: float) -> float:
	if angle > 0 and angle <= PI / 2: # bottom right
		return lerpf(mid_head_tilt_rads, min_head_tilt_rads, angle / (PI / 2))
	if angle > PI / 2: # bottom left
		return lerpf(min_head_tilt_rads, mid_head_tilt_rads, (angle - PI / 2 ) / (PI / 2))
	if angle < 0 and angle >= -PI / 2: # top right:
		return lerpf(mid_head_tilt_rads, max_head_tilt_rads, angle / (-PI / 2))
	else: # angle < -PI / 2: # top left
		return lerpf(max_head_tilt_rads, mid_head_tilt_rads, (angle + PI / 2) / (-PI / 2))
