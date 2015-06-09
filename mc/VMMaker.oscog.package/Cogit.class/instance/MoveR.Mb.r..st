abstract instructions
MoveR: sourceReg Mb: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRMbr operand: sourceReg quickConstant: offset operand: baseReg