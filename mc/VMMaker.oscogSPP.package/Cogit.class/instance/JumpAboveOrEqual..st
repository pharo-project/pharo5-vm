abstract instructions
JumpAboveOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self genConditionalBranch: JumpAboveOrEqual operand: jumpTarget asInteger