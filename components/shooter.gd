extends Node2D
class_name Shooter

@export var bullet_scene: PackedScene

func _process(delta):
	pass
	#rotate(0.05)

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	get_tree().current_scene.add_child(bullet)
