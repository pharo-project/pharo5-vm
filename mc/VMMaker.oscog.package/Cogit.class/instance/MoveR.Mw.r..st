abstract instructions
MoveR: sourceReg Mw: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRMwr operand: sourceReg quickConstant: offset operand: baseReg