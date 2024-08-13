extends Node

@export var audioResources: Array[AudioResource] = []

var _clips: Dictionary = {}

var _currentPlayer: AudioStreamPlayer
var _incomingPlayer: AudioStreamPlayer
var _intermediatePlayer: AudioStreamPlayer # Empty player, will be used to swap references

var _fading: bool = false
var _fadeRate: float = 0

var _volume: float = 1

func _init(resources: Array[AudioResource] = []):
	audioResources = resources

func _ready():
	_initializePlayers()
	_initializeClips()

func _initializePlayers():
	_currentPlayer = AudioStreamPlayer.new()
	_incomingPlayer = AudioStreamPlayer.new()
	add_child(_currentPlayer)
	add_child(_incomingPlayer)

func _initializeClips():
	for resource in audioResources:
		if resource.audioStreams.size() != 1:
			continue
		_clips[resource.referenceString] = resource.audioStreams[0]

func PlayMusicClip(reference: String, crossfade: float = 0):
	_incomingPlayer.stream = _clips[reference]
	_incomingPlayer.volume_db = linear_to_db(0)
	_incomingPlayer.bus = "BGM"
	_incomingPlayer.play()
	_fading = true
	if crossfade <= 0:
		_fadeRate = 100
	else:
		_fadeRate = 1 / crossfade

func SetVolume(vol: float):
	_volume = vol
	if not _fading:
		_currentPlayer.volume_db = linear_to_db(vol)
		_incomingPlayer.volume_db = linear_to_db(vol)

func _process(delta):
	if _fading:
		_fadeMusic(delta)

func _fadeMusic(delta: float):
	
	_currentPlayer.volume_db = linear_to_db(db_to_linear(_currentPlayer.volume_db) - (delta * _fadeRate * _volume))
	_incomingPlayer.volume_db = linear_to_db(db_to_linear(_incomingPlayer.volume_db) + (delta * _fadeRate * _volume))
	
	if db_to_linear(_currentPlayer.volume_db) <= 0 or db_to_linear(_incomingPlayer.volume_db) >= _volume:
		_fading = false
		_intermediatePlayer = _currentPlayer
		_currentPlayer = _incomingPlayer
		_incomingPlayer = _intermediatePlayer
		_currentPlayer.volume_db = linear_to_db(_volume)
		_incomingPlayer.stop()
