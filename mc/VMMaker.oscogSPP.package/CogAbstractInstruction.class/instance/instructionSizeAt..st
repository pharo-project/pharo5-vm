disassembly
instructionSizeAt: pc
	"Answer the instruction size at pc. This is used in method disassembly
	 to decode the jumps in block dispatch to discover where block methods
	 occur within a larger method."
	^self subclassResponsibility