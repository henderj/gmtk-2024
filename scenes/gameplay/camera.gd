extends Camera2D

@export var player: Node2D
@export var boss: Node2D

@export var minDistanceBeforeZoom: float = 500
@export var maxDistanceAfterZoom: float = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position = (player.global_position * 1.5 + boss.global_position) / 2
	
	var distance = (player.global_position - boss.global_position).length()
	
	zoom = lerp(Vector2.ONE, Vector2.ONE / 4, clamp((distance / maxDistanceAfterZoom), 0, 1))
