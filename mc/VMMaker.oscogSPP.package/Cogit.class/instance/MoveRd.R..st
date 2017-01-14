abstract instructions
MoveRd: srcDPReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	self assert: objectMemory wordSize = 8.
	^self gen: MoveRdR operand: srcDPReg operand: destReg