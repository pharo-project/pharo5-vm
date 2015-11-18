abstract instructions
SubCheckOverflowR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	backEnd hasConditionRegister ifTrue:
		[^self SubR: reg1 R: reg2].
	^self gen: SubCheckOverflowRR operand: reg1 operand: reg2