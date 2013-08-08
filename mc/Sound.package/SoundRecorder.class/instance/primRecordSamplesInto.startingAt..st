primitives
primRecordSamplesInto: aWordArray startingAt: index
	"Record a sequence of 16-bit sound samples into the given array starting at the given sample index. Return the number of samples recorded, which may be zero if no samples are currently available."

	<primitive: 'primitiveSoundRecordSamples' module: 'SoundPlugin'>
	self primitiveFailed
