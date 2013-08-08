sound generation
reset

	super reset.
	sound reset.
	samplesPerIteration := sound samplesRemaining.
	iterationCount == #forever
		ifTrue: [iteration := 1]
		ifFalse: [iteration := iterationCount].
