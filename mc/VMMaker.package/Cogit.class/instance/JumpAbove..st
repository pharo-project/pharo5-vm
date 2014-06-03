abstract instructions
JumpAbove: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpAbove operand: jumpTarget asInteger