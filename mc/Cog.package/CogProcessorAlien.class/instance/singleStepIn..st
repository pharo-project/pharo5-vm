execution
singleStepIn: aMemory
	| result |
	result := self primitiveSingleStepInMemory: aMemory minimumAddress: 0 readOnlyBelow: aMemory size.
	result ~~ self ifTrue:
		[self error: 'eek!']