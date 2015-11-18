abstract instructions
JumpNoOverflow: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self previousInstruction noteFollowingConditionalBranch:
		(self gen: JumpNoOverflow operand: jumpTarget asInteger)