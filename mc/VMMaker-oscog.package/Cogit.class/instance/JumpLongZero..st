abstract instructions
JumpLongZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: JumpLongZero operand: jumpTarget asInteger