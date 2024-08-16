extends Node2D

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var angle_to_mouse = global_position.angle_to_point(mouse_pos)
	$ArmOrigin.global_rotation = angle_to_mouse
	var x_scale = 1
	if mouse_pos.x < global_position.x:
		x_scale = -1
	self.scale = Vector2(x_scale, 1)
