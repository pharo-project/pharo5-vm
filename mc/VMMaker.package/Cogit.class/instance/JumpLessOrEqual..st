abstract instructions
JumpLessOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpLessOrEqual operand: jumpTarget asInteger