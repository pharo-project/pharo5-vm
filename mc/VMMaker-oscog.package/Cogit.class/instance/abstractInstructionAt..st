compile abstract instructions
abstractInstructionAt: index
	<cmacro: '(index) (&abstractOpcodes[index])'>
	^abstractOpcodes at: index