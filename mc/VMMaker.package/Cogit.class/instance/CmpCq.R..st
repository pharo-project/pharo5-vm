abstract instructions
CmpCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpCqR operand: quickConstant operand: reg