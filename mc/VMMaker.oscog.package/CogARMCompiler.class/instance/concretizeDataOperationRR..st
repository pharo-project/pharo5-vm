generate machine code - concretize
concretizeDataOperationRR: armOpcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then op R, RISCTempReg"
	<inline: true>
	| rn rd srcReg |
	srcReg := self concreteRegister: (operands at: 0).
	rn := (self concreteRegister: (operands at: 1)).
	rd := armOpcode = CmpOpcode ifTrue: [0] ifFalse: [rn].
	self machineCodeAt: 0 
		put: (self type: 0 op: armOpcode set: 1 rn: rn rd: rd shifterOperand: srcReg).
	^machineCodeSize := 4.