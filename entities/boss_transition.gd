extends Node2D

signal all_bosses_killed
signal finished_killing

@export var bosses: Array[Node2D] = []
@export var musicTracks: Array[String] = ["in_a_heartbeat", "igor", "darkshadow"]

var currentIndex = 0

@onready var killBossParticle1 = $BigExplosion
@onready var killBossParticle2 = $BigExplosion2

var readyToKill = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func TransitionToBoss():
	global_position = get_viewport_rect().size / 2
	
	#do boss spawning
	
	
	#bosses[currentIndex].global_position = global_position
	bosses[currentIndex].process_mode = Node.PROCESS_MODE_INHERIT
	bosses[currentIndex].visible = true
	
func PrepToKill():
	readyToKill = true

func KillBoss():
	
	if not readyToKill:
		return
	
	readyToKill = false
	
	global_position = bosses[currentIndex].global_position
	killBossParticle1.restart()
	killBossParticle1.emitting = true
	killBossParticle2.restart()
	killBossParticle2.emitting = true
	bosses[currentIndex].visible = false
	bosses[currentIndex].process_mode = Node.PROCESS_MODE_DISABLED
	currentIndex += 1
		
	if currentIndex >= bosses.size():
		all_bosses_killed.emit()
	else:
		MusicPlayer.PlayMusicClip(musicTracks[currentIndex], 6)
		
	
	
	await get_tree().create_timer(3).timeout

	finished_killing.emit()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
