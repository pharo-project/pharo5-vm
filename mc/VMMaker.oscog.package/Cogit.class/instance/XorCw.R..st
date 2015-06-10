abstract instructions
XorCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: XorCwR literal: wordConstant operand: reg