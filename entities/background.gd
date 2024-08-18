extends Node2D

@export var player: Node2D
@export var damping: float = 0.1

var origin: Vector2

func _ready():
	origin = global_position

func _process(delta):
	if player != null:
		var player_dist = player.global_position - origin
		var view_offset = player_dist * -damping
		global_position = view_offset + origin
