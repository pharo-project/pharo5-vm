abstract instructions
JumpNegative: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpNegative operand: jumpTarget asInteger