abstract instructions
AddCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddCwR literal: wordConstant operand: reg