compile abstract instructions
abstractInstructionAt: index
	<cmacro: '(index) (&abstractOpcodes[index])'>
	(debugOpcodeIndices includes: index) ifTrue: [self halt].
	^abstractOpcodes at: index