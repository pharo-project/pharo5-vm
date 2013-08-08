playing
samplesRemaining
	"Answer the number of samples remaining to be played."

	| result |
	(stream isNil or: [stream closed]) ifTrue: [^ 0].
	self repeat ifTrue: [^ 1000000].
	result := (totalSamples - self currentSampleIndex) max: 0.
	result <= 0 ifTrue: [self closeFile].
	^ result
