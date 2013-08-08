execution
runInMemory: aMemory
	| result |
	result := self primitiveRunInMemory: aMemory minimumAddress: 0 readOnlyBelow: 0.
	result ~~ self ifTrue:
		[self error: 'eek!']