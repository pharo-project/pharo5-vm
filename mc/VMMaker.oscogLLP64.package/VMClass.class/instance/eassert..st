debug support
eassert: aBooleanExpressionOrBlock
	"This is for expensive asserts that we're only interested in checking in extremis.
	 For example now that Spur objStacks are debugged there's no benefit to
	 evaluating isValidObjStack: throughout the mark loop because its damn slow."
	<doNotGenerate>
	ExpensiveAsserts ifTrue:
		[aBooleanExpressionOrBlock value ifFalse:
			[AssertionFailure signal: 'Assertion failed']]