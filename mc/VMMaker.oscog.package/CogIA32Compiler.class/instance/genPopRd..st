abstract instructions
genPopRd: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	inst := cogit MoveM64: 0 r: SPReg Rd: reg .
	cogit AddCq: 8 R: SPReg.
	^ inst