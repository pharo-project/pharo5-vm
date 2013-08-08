recording controls
startRecording
	"Turn of the sound input driver and start the recording process. Initially, recording is paused."

	| semaIndex |
	recordLevel ifNil: [recordLevel := 0.5].  "lazy initialization"
	self class canRecordWhilePlaying ifFalse: [SoundPlayer shutDown].
	recordProcess ifNotNil: [self stopRecording].
	paused := true.
	meteringBuffer := SoundBuffer newMonoSampleCount: 1024.
	meterLevel := 0.
	self allocateBuffer.
	bufferAvailableSema := Semaphore new.
	semaIndex := Smalltalk registerExternalObject: bufferAvailableSema.
	self primStartRecordingDesiredSampleRate: samplingRate asInteger
		stereo: stereo
		semaIndex: semaIndex.
	RecorderActive := true.
	samplingRate := self primGetActualRecordingSampleRate.
	self primSetRecordLevel: (1000.0 * recordLevel) asInteger.
	recordProcess := [self recordLoop] newProcess.
	recordProcess priority: Processor userInterruptPriority.
	recordProcess resume.
