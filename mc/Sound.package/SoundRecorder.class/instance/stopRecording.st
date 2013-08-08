recording controls
stopRecording
	"Stop the recording process and turn of the sound input driver."

	recordProcess ifNotNil: [recordProcess terminate].
	recordProcess := nil.
	self primStopRecording.
	RecorderActive := false.
	Smalltalk unregisterExternalObject: bufferAvailableSema.
	((currentBuffer ~~ nil) and: [nextIndex > 1])
		ifTrue: [self emitPartialBuffer].
	self initializeRecordingState.
