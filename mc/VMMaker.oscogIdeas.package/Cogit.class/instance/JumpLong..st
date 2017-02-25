abstract instructions
JumpLong: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: JumpLong operand: jumpTarget