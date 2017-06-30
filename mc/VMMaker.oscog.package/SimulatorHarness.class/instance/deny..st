testing
deny: aBooleanOrBlock
	aBooleanOrBlock value ifTrue: [AssertionFailure signal: 'Assertion failed']