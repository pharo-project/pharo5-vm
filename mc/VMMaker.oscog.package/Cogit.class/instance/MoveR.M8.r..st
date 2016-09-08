abstract instructions
MoveR: sourceReg M8: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRM8r operand: sourceReg quickConstant: offset operand: baseReg