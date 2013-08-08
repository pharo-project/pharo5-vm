initialization
setPitch: pitchNameOrNumber dur: d loudness: vol
	"(LoopedSampledSound pitch: 440.0 dur: 2.5 loudness: 0.4) play"

	super setPitch: pitchNameOrNumber dur: d loudness: vol.
	self pitch: (self nameOrNumberToPitch: pitchNameOrNumber).
	self reset.
