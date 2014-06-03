error handling
handleCallFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a call into a ProcessorSimulationTrap signal."
	|  callAddress failedInstruction|
	"grab the instruction at issue"
	failedInstruction := memoryArray unsignedLongAt: pc + 1 bigEndian: false.
	(self instructionIsBL: failedInstruction)
		ifFalse:[self halt].
	"short jump via BL, therefore we have a 24bit signed integer offset"
	callAddress := (pc + 8 + (self extractOffsetFromBL: failedInstruction)).

	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: callAddress signedIntToLong
			type: #call)
		signal