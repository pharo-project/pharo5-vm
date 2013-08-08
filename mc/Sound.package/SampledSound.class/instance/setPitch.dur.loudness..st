initialization
setPitch: pitchNameOrNumber dur: d loudness: vol
	"Used to play scores using the default sample table."
	"(SampledSound pitch: 880.0 dur: 1.5 loudness: 0.6) play"

	| p |
	super setPitch: pitchNameOrNumber dur: d loudness: vol.
	p := self nameOrNumberToPitch: pitchNameOrNumber.
	samples := DefaultSampleTable.
	samplesSize := samples size.
	initialCount := (d * self samplingRate asFloat) rounded.
	originalSamplingRate :=
		((self samplingRate asFloat * p asFloat) / NominalSamplePitch asFloat) asInteger.
	self loudness: vol.
	self reset.
