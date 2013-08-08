instance creation
pitch: p dur: d loudness: l
	"Return a rest of the given duration."
	"Note: This message allows one to silence one or more voices of a multi-voice piece by using RestSound as their instrument."

	^ self new setDur: d
