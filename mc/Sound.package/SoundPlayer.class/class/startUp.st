snapshotting
startUp
	"Start up the player process."

	SoundPlayer initialize.
	SoundPlayer
		startPlayerProcessBufferSize: (BufferMSecs * SamplingRate) // 1000
		rate: SamplingRate
		stereo: Stereo.
