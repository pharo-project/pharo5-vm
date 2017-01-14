generate machine code - concretize
concretizeDataOperationCwR: armOpcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then cmp R, RISCTempReg"
	<inline: true>
	| constant rn rd instrOffset|
	constant := operands at: 0.
	rn := operands at: 1.
	rd := armOpcode = CmpOpcode ifTrue: [0] ifFalse:[rn].
	instrOffset := self moveCw: constant intoR: ConcreteIPReg.
	self machineCodeAt: instrOffset 
		put: (self type: 0 op: armOpcode set: 1 rn: rn rd: rd shifterOperand: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4