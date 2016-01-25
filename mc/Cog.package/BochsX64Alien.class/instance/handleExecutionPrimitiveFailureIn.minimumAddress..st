error handling
handleExecutionPrimitiveFailureIn: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress
	"Handle an execution primitive failure.  Convert out-of-range call and absolute
	 memory read into register instructions into ProcessorSimulationTrap signals."
	"self printIntegerRegistersOn: Transcript"
	"self printRegistersOn: Transcript"
	| pc opcode rexByteOrNil offset |
	((pc := self rip) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[opcode := memoryArray byteAt: pc + (offset := 1).
		 (opcode bitAnd: 16rF8) = self rexPrefix ifTrue: "skip rex prefix if present"
			[rexByteOrNil := opcode.
			 opcode := memoryArray byteAt: pc + (offset := 2)].
		 ^self
			perform: (OpcodeExceptionMap at: opcode + 1)
			with: pc
			with: memoryArray
			with: rexByteOrNil].
	^self reportPrimitiveFailure