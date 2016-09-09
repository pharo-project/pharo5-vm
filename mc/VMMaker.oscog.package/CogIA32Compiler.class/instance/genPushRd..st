abstract instructions
genPushRd: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	inst := cogit MoveRd: reg M64: -8 r: SPReg.
	cogit SubCq: 8 R: SPReg.
	^ inst