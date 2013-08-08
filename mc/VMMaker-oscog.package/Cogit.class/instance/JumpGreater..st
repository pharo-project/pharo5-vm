abstract instructions
JumpGreater: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpGreater operand: jumpTarget asInteger