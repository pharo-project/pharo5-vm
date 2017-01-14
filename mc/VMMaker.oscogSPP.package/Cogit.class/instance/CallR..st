abstract instructions
CallR: callTarget 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CallR operand: callTarget