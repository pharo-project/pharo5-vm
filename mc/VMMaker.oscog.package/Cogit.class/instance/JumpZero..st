abstract instructions
JumpZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpZero operand: jumpTarget asInteger)