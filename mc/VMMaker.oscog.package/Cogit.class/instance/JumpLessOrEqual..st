abstract instructions
JumpLessOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpLessOrEqual operand: jumpTarget asInteger)