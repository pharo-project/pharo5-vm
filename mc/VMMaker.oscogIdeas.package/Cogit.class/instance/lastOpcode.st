compile abstract instructions
lastOpcode
	<returnTypeC: #'AbstractInstruction *'>
	self assert: opcodeIndex > 0.
	^self abstractInstructionAt: opcodeIndex - 1