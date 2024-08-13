extends Node

@export var audioStreamResource: AudioStream 
@export var audioBus: String

var _seedAudioStreamPlayer: AudioStreamPlayer

func _init(stream: AudioStream, bus: String):
	audioStreamResource = stream
	audioBus = bus

func _ready():
	_seedAudioStreamPlayer = AudioStreamPlayer.new()
	_seedAudioStreamPlayer.stream = audioStreamResource
	_seedAudioStreamPlayer.volume_db = linear_to_db(1)
	_seedAudioStreamPlayer.pitch_scale = 1
	_seedAudioStreamPlayer.bus = audioBus
	

func instantiatePlayer() -> AudioStreamPlayer:
	var newPlayer: AudioStreamPlayer = _seedAudioStreamPlayer.duplicate()
	add_child(newPlayer)
	return newPlayer

func PlaySound():
	var player = instantiatePlayer()
	player.play()
	
	await player.finished
	player.queue_free()
