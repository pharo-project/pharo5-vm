abstract instructions
JumpAboveOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpAboveOrEqual operand: jumpTarget asInteger