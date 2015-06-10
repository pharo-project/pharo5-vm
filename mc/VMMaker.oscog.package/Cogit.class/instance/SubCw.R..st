abstract instructions
SubCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubCwR literal: wordConstant operand: reg