generate machine code - concretize
concretizeDataOperationCwR: opcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then cmp R, RISCTempReg"
	<inline: true>
	| constant rn rd instrOffset|
	constant := operands at: 0.
	rn := (self concreteRegister: (operands at: 1)).
	rd := opcode = CmpOpcode ifTrue: [0] ifFalse:[rn].
	instrOffset := self at: 0 moveCw: constant intoR: RISCTempReg.
	self machineCodeAt: instrOffset 
		put: (self type: 0 op: opcode set: 1 rn: rn rd: rd shifterOperand: RISCTempReg).
	^machineCodeSize := instrOffset + 4