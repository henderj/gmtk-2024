extends Node2D

@export var backgrounds: Array[Node2D] = []
@export var zoom_duration: float = 3
@export var zoom_to: float = 100

var current_bg: int = 0

func _ready():
	if backgrounds.size() == 0:
		print('warning: no backgrounds')
		return
	for bg in backgrounds:
		bg.scale = Vector2.ZERO
	backgrounds[0].scale = Vector2.ONE

func next_bg():
	current_bg += 1
	if current_bg >= backgrounds.size():
		print('warning: no more backgrounds')
		return
	var old_bg = backgrounds[(current_bg - 1) % backgrounds.size()]
	var new_bg = backgrounds[current_bg]
	var tween = get_tree().create_tween()
	tween.tween_property(old_bg, 'scale', 
		Vector2.ONE * zoom_to, zoom_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(old_bg, 'modulate:a', 
		0, zoom_duration)
	tween.parallel().tween_property(new_bg, 'scale', 
		Vector2.ONE, zoom_duration).from(Vector2.ZERO).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(new_bg, 'modulate:a', 
		1, zoom_duration).from(0)
