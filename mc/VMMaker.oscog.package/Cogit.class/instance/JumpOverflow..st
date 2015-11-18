abstract instructions
JumpOverflow: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpOverflow operand: jumpTarget asInteger)