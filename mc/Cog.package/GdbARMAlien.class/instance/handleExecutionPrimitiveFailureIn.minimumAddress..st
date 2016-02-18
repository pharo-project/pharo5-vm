error handling
handleExecutionPrimitiveFailureIn: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress "<Integer>"
	"Handle an execution primitive failure.  Convert out-of-range call and absolute
	 memory read into register instructions into ProcessorSimulationTrap signals."
	"self printRegistersOn: Transcript"
	| pcOnEntry pc instr |
	pcOnEntry := self pc.
	self endCondition = InstructionPrefetchError ifTrue:
		[self pc: self priorPc].

	((pc := self pc) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[instr := memoryArray unsignedLongAt:  pc + 1 bigEndian: false.

		 (self endCondition = InstructionPrefetchError) ifTrue:
			[^self handleFailingBranch: instr to: pcOnEntry at: pc].

		 (self instructionIsAnyLoadStore: instr) ifTrue:
			[^self handleFailingLoadStore: instr at: pc].

		 ^self handleExecutionPrimitiveFailureAt: pc in: memoryArray].

	^self reportPrimitiveFailure