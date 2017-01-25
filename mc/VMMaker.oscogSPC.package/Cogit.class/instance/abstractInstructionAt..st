compile abstract instructions
abstractInstructionAt: index
	<cmacro: '(index) (&abstractOpcodes[index])'>
	((debugOpcodeIndices includes: index)
	 and: [breakMethod isNil or: [methodObj = breakMethod]]) ifTrue:
		[self halt].
	^abstractOpcodes at: index