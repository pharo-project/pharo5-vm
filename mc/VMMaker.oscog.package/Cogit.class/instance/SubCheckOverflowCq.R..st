abstract instructions
SubCheckOverflowCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	backEnd hasConditionRegister ifTrue:
		[^self SubCq: quickConstant R: reg].
	^self gen: SubCheckOverflowCqR quickConstant: quickConstant operand: reg