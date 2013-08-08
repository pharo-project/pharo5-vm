execution
runInMemory: aMemory readExecuteOnlyBelow: minWriteMaxExecAddr
	| result |
	result := self primitiveRunInMemory: aMemory minimumAddress: 0 readOnlyBelow: minWriteMaxExecAddr.
	result ~~ self ifTrue:
		[self error: 'eek!']