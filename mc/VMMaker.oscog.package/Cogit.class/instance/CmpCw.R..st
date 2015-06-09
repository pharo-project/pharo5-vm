abstract instructions
CmpCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpCwR literal: wordConstant operand: reg