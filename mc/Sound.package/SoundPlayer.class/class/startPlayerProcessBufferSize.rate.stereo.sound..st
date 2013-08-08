player process
startPlayerProcessBufferSize: bufferSize rate: samplesPerSecond stereo: stereoFlag sound: aSound
	"Start the sound player process. Terminate the old process, if any."
	"SoundPlayer startPlayerProcessBufferSize: 1000 rate: 11025 stereo: false"

	self stopPlayerProcess.
	aSound
		ifNil:[ActiveSounds := OrderedCollection new]
		ifNotNil:[ActiveSounds := OrderedCollection with: aSound].
	Buffer := SoundBuffer newStereoSampleCount: (bufferSize // 4) * 4.
	LastBuffer ifNotNil:[LastBuffer := SoundBuffer basicNew: Buffer basicSize].
	PlayerSemaphore := Semaphore forMutualExclusion.
	SamplingRate := samplesPerSecond.
	Stereo := stereoFlag.
	ReadyForBuffer := Semaphore new.
	SoundSupported := true. "Assume so"
	UseReadySemaphore := true.  "set to false if ready semaphore not supported by VM"
	self primSoundStartBufferSize: Buffer stereoSampleCount
		rate: samplesPerSecond
		stereo: Stereo
		semaIndex: (Smalltalk registerExternalObject: ReadyForBuffer).
	"Check if sound start prim was successful"
	SoundSupported ifFalse:[^self].
	UseReadySemaphore
		ifTrue: [PlayerProcess := [SoundPlayer playLoop] newProcess]
		ifFalse: [PlayerProcess := [SoundPlayer oldStylePlayLoop] newProcess].
	UseReverb ifTrue: [self startReverb].

	PlayerProcess priority: Processor userInterruptPriority.
	PlayerProcess resume.