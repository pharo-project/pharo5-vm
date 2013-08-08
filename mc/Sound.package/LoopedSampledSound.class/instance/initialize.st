initialization
initialize
	"This default initialization creates a loop consisting of a single cycle of a sine wave."
	"(LoopedSampledSound pitch: 440.0 dur: 1.0 loudness: 0.4) play"

	| samples |
	super initialize.
	samples := FMSound sineTable.
	self samples: samples
		loopEnd: samples size
		loopLength: samples size
		pitch: 1.0
		samplingRate: samples size.
	self addReleaseEnvelope.
	self setPitch: 440.0 dur: 1.0 loudness: 0.5.
