generate machine code - concretize
concretizeFill32
	"fill with operand 0 according to the processor's endianness.
	 You might think this is bogus and we should fill with stop instrurctions instead,
	 but this is used to leave room for a CMBlock header before the code for a block;
	 the gaps get filled in by fillInBlockHeadersAt: after code has been generated."
	self machineCodeAt: 0 put: (operands at: 0).
	^machineCodeSize := 4