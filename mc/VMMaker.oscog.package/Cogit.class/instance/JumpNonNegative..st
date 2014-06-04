abstract instructions
JumpNonNegative: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: JumpNonNegative operand: jumpTarget asInteger