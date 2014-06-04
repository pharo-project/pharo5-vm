abstract instructions
AndCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AndCwR operand: wordConstant operand: reg