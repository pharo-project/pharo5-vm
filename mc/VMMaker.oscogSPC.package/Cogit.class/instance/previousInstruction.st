compile abstract instructions
previousInstruction
	<returnTypeC: #'AbstractInstruction *'>
	self assert: opcodeIndex > 0.
	^self abstractInstructionAt: opcodeIndex - 1