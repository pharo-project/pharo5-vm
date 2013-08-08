initialization
pitch: pitchNameOrNumber

	| p |
	p := self nameOrNumberToPitch: pitchNameOrNumber.
	originalSamplingRate :=
		((self samplingRate asFloat * p asFloat) / NominalSamplePitch asFloat) asInteger.
	self reset.
