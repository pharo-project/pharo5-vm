abstract instructions
JumpGreaterOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpGreaterOrEqual operand: jumpTarget asInteger