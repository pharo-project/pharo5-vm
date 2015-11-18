abstract instructions
JumpLongZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpLongZero operand: jumpTarget asInteger)