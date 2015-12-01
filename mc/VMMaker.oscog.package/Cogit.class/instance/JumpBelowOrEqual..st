abstract instructions
JumpBelowOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self genConditionalBranch: JumpBelowOrEqual operand: jumpTarget asInteger