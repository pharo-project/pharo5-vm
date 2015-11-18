abstract instructions
AddCheckOverflowCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	backEnd hasConditionRegister ifTrue:
		[^self AddCq: quickConstant R: reg].
	^self gen: AddCheckOverflowCqR quickConstant: quickConstant operand: reg