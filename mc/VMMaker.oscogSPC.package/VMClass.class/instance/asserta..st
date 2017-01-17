debug support
asserta: aBooleanExpression
	<doNotGenerate>
	| result |
	(result := aBooleanExpression value) ifFalse:
		[AssertionFailure signal: 'Assertion failed'].
	^result