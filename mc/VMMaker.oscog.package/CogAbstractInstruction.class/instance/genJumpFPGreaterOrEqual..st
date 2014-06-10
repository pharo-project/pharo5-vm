abstract instructions
genJumpFPGreaterOrEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPGreaterOrEqual operand: jumpTarget asInteger