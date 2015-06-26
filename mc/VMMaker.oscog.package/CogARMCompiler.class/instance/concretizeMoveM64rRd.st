generate machine code - concretize
concretizeMoveM64rRd
	"Will get inlined into concretizeAt: switch."	
	<inline: true>
	"Load a float from srcReg+offset into FP destReg"
	| srcReg offset destReg u|
	offset := operands at: 0.
	u := offset >0 ifTrue:[1] ifFalse:[0].
	srcReg := self concreteRegister: (operands at: 1).
	destReg := self concreteDPFPRegister: (operands at: 2).
	machineCode at: 0 put: (self fldd: destReg rn: srcReg plus: u imm: offset>>2).
	^machineCodeSize := 4
