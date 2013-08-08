other
memorySpace
	"Answer the number of bytes required to store the samples for this instrument."

	| total |
	total := 0.
	self allNotes do: [:n |
		total := total + (n leftSamples monoSampleCount * 2).
		n isStereo ifTrue: [total := total + (n leftSamples monoSampleCount * 2)]].
	^ total
