abstract instructions
JumpCarry: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpCarry operand: jumpTarget asInteger