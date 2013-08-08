abstract instructions
MoveR: sourceReg Mw: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRMwr operand: sourceReg operand: offset operand: baseReg