gc - global
traceImmediatelySlotLimit
	"Arbitrary level at which to defer tracing large objects until later.
	 The average slot size of Smalltalk objects is typically near 8.
	 We do require traceImmediatelySlotLimit to be < numSlotsMask."
	^64