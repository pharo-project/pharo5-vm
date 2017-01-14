abstract instructions
genPushRs: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| inst |
	inst := cogit MoveRs: reg M32: -4 r: SPReg.
	cogit SubCq: 4 R: SPReg.
	^ inst