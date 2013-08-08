initialization
setPitch: pitchNameOrNumber dur: d loudness: vol

	| p sz |
	super setPitch: pitchNameOrNumber dur: d loudness: vol.
	p := self nameOrNumberToPitch: pitchNameOrNumber.
	initialCount := (d * self samplingRate asFloat) asInteger.
	ring := SoundBuffer newMonoSampleCount:
		(((2.0 * self samplingRate) / p) asInteger max: 2).
	sz := ring monoSampleCount.
	scaledIndexLimit := (sz + 1) * ScaleFactor.
	scaledIndexIncr := (p * sz * ScaleFactor) // (2.0 * self samplingRate).
	self reset.
