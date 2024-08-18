extends Node2D

@export var player: Node2D
@export var damping: float = 0.1

var center: Vector2

func _ready():
	center = get_viewport_rect().size / 2

func _process(delta):
	if player != null:
		var player_dist = player.global_position - center
		var view_offset = player_dist * -damping
		global_position = view_offset
