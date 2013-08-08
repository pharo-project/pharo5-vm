abstract instructions
JumpBelow: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpBelow operand: jumpTarget asInteger