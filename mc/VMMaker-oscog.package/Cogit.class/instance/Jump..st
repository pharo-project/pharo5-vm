abstract instructions
Jump: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^self gen: Jump operand: jumpTarget asInteger