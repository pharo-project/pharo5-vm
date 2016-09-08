abstract instructions
genPopRs: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	inst := cogit MoveM32: 0 r: SPReg Rs: reg .
	cogit AddCq: 4 R: SPReg.
	^ inst