abstract instructions
SubCw: wordConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubCwR operand: wordConstant operand: reg