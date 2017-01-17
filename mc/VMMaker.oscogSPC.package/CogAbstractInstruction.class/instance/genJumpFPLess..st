abstract instructions
genJumpFPLess: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	^cogit gen: JumpFPLess operand: jumpTarget asInteger