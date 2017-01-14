abstract instructions
AddCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddCqR quickConstant: quickConstant operand: reg