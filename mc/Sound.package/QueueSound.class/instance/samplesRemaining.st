sound generation
samplesRemaining
	(done and: [self sounds isEmpty])
		ifTrue: [^ 0]
		ifFalse: [^ 1000000].
