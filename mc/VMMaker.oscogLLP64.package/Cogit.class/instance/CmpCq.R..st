abstract instructions
CmpCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpCqR quickConstant: quickConstant operand: reg