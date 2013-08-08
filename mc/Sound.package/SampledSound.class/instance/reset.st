playing
reset
	"Details: The sample index and increment are scaled to allow fractional increments without having to do floating point arithmetic in the inner loop."

	super reset.
	scaledIncrement :=
		((originalSamplingRate asFloat / self samplingRate) * IncrementScaleFactor) rounded.
	count := initialCount.
	scaledIndex := IncrementScaleFactor.  "index of the first sample, scaled"
	indexHighBits := 0.
