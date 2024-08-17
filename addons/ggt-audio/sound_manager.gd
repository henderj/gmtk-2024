extends Node

@export var audioResources: Array[AudioResource] = []

@onready var musicPlayer = $MusicPlayer

var _soundSources:Dictionary = {}

const SoundPool = preload("res://addons/ggt-audio/sound_pool.gd")
const SoundQueue = preload("res://addons/ggt-audio/sound_queue.gd")

func _ready():
	initializeAudioSources()

func initializeAudioSources():
	for resource in audioResources:
		if resource.audioStreams.size() > 1:
			var pool = SoundPool.new(resource.audioStreams, resource.audioBus)
			add_child(pool)
			_soundSources[resource.referenceString] = pool
		elif resource.audioStreams.size() == 1:
			var queue = SoundQueue.new(resource.audioStreams[0], resource.audioBus)
			add_child(queue)
			_soundSources[resource.referenceString] = queue

func PlaySound(referenceString: String):
	var source = _soundSources[referenceString]
	#print(referenceString)
	source.PlaySound()
