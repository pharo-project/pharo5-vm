abstract instructions
AddCheckOverflowR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	backEnd hasConditionRegister ifTrue:
		[^self AddR: reg1 R: reg2].
	^self gen: AddCheckOverflowRR operand: reg1 operand: reg2