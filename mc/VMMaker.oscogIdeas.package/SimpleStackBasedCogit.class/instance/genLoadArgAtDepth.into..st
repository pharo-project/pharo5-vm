primitive generators
genLoadArgAtDepth: n into: reg
	"Load an argument at depth from top-of-stack (0 relative) into a register.
	 The actual offset depends on whether there's a link register or not."
	self MoveMw: (backEnd hasLinkRegister ifTrue: [n] ifFalse: [n + 1]) * objectMemory wordSize
		r: SPReg
		R: reg