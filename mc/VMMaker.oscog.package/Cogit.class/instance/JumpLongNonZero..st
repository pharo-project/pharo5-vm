abstract instructions
JumpLongNonZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpLongNonZero operand: jumpTarget asInteger)