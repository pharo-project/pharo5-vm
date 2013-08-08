abstract instructions
AddCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddCwR operand: wordConstant operand: reg