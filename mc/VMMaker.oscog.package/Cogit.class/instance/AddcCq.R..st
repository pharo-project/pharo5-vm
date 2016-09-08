abstract instructions
AddcCq: quickConstant R: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddcCqR quickConstant: quickConstant operand: reg