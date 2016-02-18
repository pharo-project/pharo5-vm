abstract instructions
JumpLongZero: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self genConditionalBranch: JumpLongZero operand: jumpTarget asInteger