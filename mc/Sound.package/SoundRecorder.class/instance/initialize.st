initialization
initialize
	"SoundRecorder new"

	super initialize.
	stereo := false.
	samplingRate := 11025.
	recordLevel := 0.5.
	self initializeRecordingState.
