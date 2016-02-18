error handling
handleExecutionPrimitiveFailureIn: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress
	"Handle an execution primitive failure.  Convert out-of-range call and absolute
	 memory read into register instructions into ProcessorSimulationTrap signals."
	"self printIntegerRegistersOn: Transcript"
	"self printRegistersOn: Transcript"
	| pc opcode |
	((pc := self eip) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[opcode := memoryArray byteAt: pc + 1.
		 opcode ~= 16r0f ifTrue:
			[^self
				perform: (OpcodeExceptionMap at: opcode + 1)
				with: pc
				with: memoryArray].
		 opcode := memoryArray byteAt: pc + 2.
		 ^self
				perform: (ExtendedOpcodeExceptionMap at: opcode + 1)
				with: pc
				with: memoryArray].
	^self reportPrimitiveFailure