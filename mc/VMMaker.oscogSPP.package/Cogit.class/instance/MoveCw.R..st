abstract instructions
MoveCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveCwR literal: wordConstant operand: reg