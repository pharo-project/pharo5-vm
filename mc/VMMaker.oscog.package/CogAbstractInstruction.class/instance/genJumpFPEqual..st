abstract instructions
genJumpFPEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPEqual operand: jumpTarget asInteger