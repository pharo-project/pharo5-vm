generate machine code - concretize
concretizePrefetchAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand |
	addressOperand := operands at: 0.
	self at: 0 moveCw: addressOperand intoR: RISCTempReg.
	"pld	[RISCTempReg, +<byte 0>]"
	"u = 1, I = 0"
	"1111 0101 1101 RTem 1111 0000 byte"
	machineCode
		at: 15 put: 16rF5;
		at: 14 put: (16rD0 bitOr: RISCTempReg);
		at: 13 put: 16rF0.
	^machineCodeSize := 16