abstract instructions
AndCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AndCwR literal: wordConstant operand: reg