abstract instructions
genJumpFPLessOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPLessOrEqual operand: jumpTarget asInteger