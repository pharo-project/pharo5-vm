private
downSampleLowPassFiltering: doFiltering
	"Cut my sampling rate in half. Use low-pass filtering (slower) if doFiltering is true."
	"Note: This operation loses information, and modifies the receiver in place."

	| stereo newLoopLength |
	stereo := self isStereo.
	leftSamples := leftSamples downSampledLowPassFiltering: doFiltering.
	stereo
		ifTrue: [rightSamples := rightSamples downSampledLowPassFiltering: doFiltering]
		ifFalse: [rightSamples := leftSamples].
	originalSamplingRate := originalSamplingRate / 2.0.
	loopEnd odd
		ifTrue: [newLoopLength := (self loopLength / 2.0) + 0.5]
		ifFalse: [newLoopLength := self loopLength / 2.0].
	firstSample := (firstSample + 1) // 2.
	lastSample := (lastSample + 1) // 2.
	loopEnd := (loopEnd + 1) // 2.
	scaledLoopLength := (newLoopLength * LoopIndexScaleFactor) asInteger.
	scaledIndexIncr := scaledIndexIncr // 2.
