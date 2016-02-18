abstract instructions
JumpAbove: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self genConditionalBranch: JumpAbove operand: jumpTarget asInteger