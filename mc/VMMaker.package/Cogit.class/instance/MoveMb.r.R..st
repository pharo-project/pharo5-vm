abstract instructions
MoveMb: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveMbrR operand: offset operand: baseReg operand: destReg