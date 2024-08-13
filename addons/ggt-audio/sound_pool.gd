extends Node

const SoundQueue = preload("res://addons/ggt-audio/sound_queue.gd")

var _soundQueues: Array[SoundQueue] = []

@export var audioStreamResources: Array[AudioStream] = []
@export var audioBus: String = "SFX"

func _init(streams: Array[AudioStream] = [], bus: String = "SFX"):
	audioStreamResources = streams
	audioBus = bus

func _ready():
	for stream in audioStreamResources:
		var soundQueue = instantiateSoundQueue(stream)

func instantiateSoundQueue(stream: AudioStream) -> SoundQueue:
	var soundQueue = SoundQueue.new(stream, audioBus)
	_soundQueues.push_back(soundQueue)
	add_child(soundQueue)
	return soundQueue
	
func PlaySound():
	_soundQueues[randi() % _soundQueues.size()].PlaySound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
