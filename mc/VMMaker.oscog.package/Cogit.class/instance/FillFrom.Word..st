abstract instructions
FillFrom: address Word: value
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: FillFromWord operand: address operand: value