abstract instructions
genJumpFPGreater: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPGreater operand: jumpTarget asInteger