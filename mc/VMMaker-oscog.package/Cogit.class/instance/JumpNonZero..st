abstract instructions
JumpNonZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpNonZero operand: jumpTarget asInteger