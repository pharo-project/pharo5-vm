abstract instructions
JumpNoCarry: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpNoCarry operand: jumpTarget asInteger