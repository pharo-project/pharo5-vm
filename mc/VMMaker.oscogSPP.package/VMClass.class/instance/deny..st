simulation support
deny: aBooleanOrBlock
	<doNotGenerate>
	aBooleanOrBlock value ifTrue: [AssertionFailure signal: 'Assertion failed']