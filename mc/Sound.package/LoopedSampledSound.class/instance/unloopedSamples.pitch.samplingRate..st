initialization
unloopedSamples: aSoundBuffer pitch: perceivedPitchInHz samplingRate: samplingRateInHz
	"Make this sound play the given samples unlooped. The samples have the given perceived pitch when played at the given sampling rate. By convention, unpitched sounds such as percussion sounds should specify a pitch of nil or 100 Hz."

	super initialize.
	leftSamples := rightSamples := aSoundBuffer.
	originalSamplingRate := samplingRateInHz asFloat.
	perceivedPitchInHz
		ifNil: [perceivedPitch := 100.0]
		ifNotNil: [perceivedPitch := perceivedPitchInHz asFloat].
	gain := 1.0.
	firstSample := 1.
	lastSample := leftSamples size.
	lastSample >= (SmallInteger maxVal // LoopIndexScaleFactor) ifTrue: [
		self error: 'cannot handle more than ',
			(SmallInteger maxVal // LoopIndexScaleFactor) printString, ' samples'].
	loopEnd := leftSamples size.
	scaledLoopLength := 0.  "zero length means unlooped"
	scaledIndexIncr := (samplingRateInHz * LoopIndexScaleFactor) // self samplingRate.
	self computeSampleCountForRelease.
