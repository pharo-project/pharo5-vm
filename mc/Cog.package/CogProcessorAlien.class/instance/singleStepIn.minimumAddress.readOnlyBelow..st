execution
singleStepIn: aMemory minimumAddress: minimumAddress readOnlyBelow: minimumWritableAddress
	| result |
	result := self primitiveSingleStepInMemory: aMemory
				minimumAddress: minimumAddress
				readOnlyBelow: minimumWritableAddress.
	result ~~ self ifTrue:
		[self error: 'eek!']