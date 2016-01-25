error handling
handleTwoByteEscapeFailureAt: pc in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil
	"Handle an execution primitive failure for the 0f prefix.  Convert failures into ProcessorSimulationTrap signals."
	"self printIntegerRegistersOn: Transcript"
	"self printRegistersOn: Transcript"
	| opcode offset |
	"assume 0fh opcode or 0fh rex opcode"
	offset := rexByteOrNil ifNil: [1] ifNotNil: [2].
	opcode := memoryArray byteAt: pc + offset + 1.
	 ^self
			perform: (ExtendedOpcodeExceptionMap at: opcode + 1)
			with: pc
			with: memoryArray
			with: rexByteOrNil