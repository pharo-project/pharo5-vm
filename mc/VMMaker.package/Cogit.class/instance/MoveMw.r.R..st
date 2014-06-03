abstract instructions
MoveMw: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveMwrR operand: offset operand: baseReg operand: destReg