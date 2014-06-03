generate machine code - concretize
concretizePrefetchAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand instrOffset|
	addressOperand := operands at: 0.
	instrOffset := self at: 0 moveCw: addressOperand intoR: RISCTempReg.
	"pld	[RISCTempReg]"
	self machineCodeAt: instrOffset put: (self pld: RISCTempReg plus: 1offset: 0).
	^machineCodeSize := instrOffset + 4