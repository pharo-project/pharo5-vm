compile abstract instructions
abstractInstructionAt: index
	<cmacro: '(index) (&abstractOpcodes[index])'>
	<returnTypeC: #'AbstractInstruction *'>
	((debugOpcodeIndices includes: index)
	 and: [breakMethod isNil or: [methodObj = breakMethod]]) ifTrue:
		[self halt].
	^abstractOpcodes at: index