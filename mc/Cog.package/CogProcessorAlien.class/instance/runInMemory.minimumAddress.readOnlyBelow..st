execution
runInMemory: aMemory minimumAddress: minimumAddress readOnlyBelow: minimumWritableAddress
	| result |
	result := self primitiveRunInMemory: aMemory
				minimumAddress: minimumAddress
				readOnlyBelow: minimumWritableAddress.
	result ~~ self ifTrue:
		[self error: 'eek!']