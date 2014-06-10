abstract instructions
JumpBelowOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpBelowOrEqual operand: jumpTarget asInteger