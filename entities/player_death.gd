extends CPUParticles2D

@export var playerNode: Node2D


func KIllPlayer():
	global_position = playerNode.global_position
	restart()
	emitting = true
