extends Sprite2D

@export var player: Node2D
@export var view: Vector2 = Vector2(-0.905, 0.27)
@export var zoom = 0.97
@export var damping: float = 0.1
@export var zoom_levels: Array[float] = []

@onready var shader: ShaderMaterial = self.material

var center: Vector2
var current_zoom: int = 0

func _ready():
	center = get_viewport_rect().size / 2
	damping /= 1000

func _process(delta):
	if player:
		var player_dist = player.global_position - center
		var view_offset = player_dist * damping
		shader.set_shader_parameter('offset', view_offset)
		
	#view.x += delta
	#zoom += delta
	#shader.set_shader_parameter('view', view)
	#shader.set_shader_parameter('zoom', zoom)

func do_zoom():
	current_zoom += 1
	if current_zoom >= zoom_levels.size():
		print('error: no more zoom levels')
	
