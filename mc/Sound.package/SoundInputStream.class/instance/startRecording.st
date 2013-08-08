recording controls
startRecording
	"Start the sound input process."

	recordProcess ifNotNil: [self stopRecording].
	recordedBuffers := OrderedCollection new: 100.
	mutex := Semaphore forMutualExclusion.
	super startRecording.
	paused := false.
