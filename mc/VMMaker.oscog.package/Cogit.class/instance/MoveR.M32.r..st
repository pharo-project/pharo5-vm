abstract instructions
MoveR: sourceReg M32: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRM32r operand: sourceReg quickConstant: offset operand: baseReg