abstract instructions
genPushRs: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	inst := cogit MoveRs: reg M32: -8 r: SPReg.
	cogit SubCq: 8 R: SPReg.
	^ inst