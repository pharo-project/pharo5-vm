abstract instructions
JumpGreater: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self genConditionalBranch: JumpGreater operand: jumpTarget asInteger