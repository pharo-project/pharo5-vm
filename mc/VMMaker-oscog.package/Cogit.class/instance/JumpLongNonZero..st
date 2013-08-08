abstract instructions
JumpLongNonZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: JumpLongNonZero operand: jumpTarget asInteger