abstract instructions
MoveR: srcReg Rd: destDPReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	self assert: objectMemory wordSize = 8.
	^self gen: MoveRRd operand: srcReg operand: destDPReg