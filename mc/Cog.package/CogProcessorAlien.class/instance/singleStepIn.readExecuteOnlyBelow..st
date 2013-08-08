execution
singleStepIn: aMemory readExecuteOnlyBelow: minWriteMaxExecAddr
	| result |
	result := self primitiveSingleStepInMemory: aMemory minimumAddress: 0 readOnlyBelow: minWriteMaxExecAddr.
	result ~~ self ifTrue:
		[self error: 'eek!']