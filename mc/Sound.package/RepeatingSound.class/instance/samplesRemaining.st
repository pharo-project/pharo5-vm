sound generation
samplesRemaining

	iterationCount == #forever ifTrue: [^ 1000000].
	iteration > 0
		ifTrue: [^ sound samplesRemaining + ((iteration - 1) * samplesPerIteration)]
		ifFalse: [^ 0].
