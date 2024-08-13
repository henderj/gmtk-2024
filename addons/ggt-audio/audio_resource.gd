class_name AudioResource extends Resource

enum SpatialState {
	NONE,
	TWO_DIMENTIONAL,
	THREE_DIMENTIONAL
}


@export var audioStreams: Array[AudioStream] = []
@export var referenceString: String = ""
@export var spacialState: SpatialState = SpatialState.NONE
@export var audioBus: String = "SFX"

func _init(
		cAudioStreams: Array[AudioStream] = [], 
		cReferenceString: String = "", 
		cSpatialState: SpatialState = SpatialState.NONE,
		cAudioBus: String = "SFX"
	):
	audioStreams = cAudioStreams
	referenceString = cReferenceString
	spacialState = cSpatialState 
	audioBus = cAudioBus
