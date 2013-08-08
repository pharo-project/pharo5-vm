abstract instructions
genJumpFPNotEqual: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPNotEqual operand: jumpTarget asInteger