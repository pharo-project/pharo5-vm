abstract instructions
JumpNonNegative: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self genConditionalBranch: JumpNonNegative operand: jumpTarget asInteger