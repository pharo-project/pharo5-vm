abstract instructions
JumpLongNonZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self genConditionalBranch: JumpLongNonZero operand: jumpTarget asInteger