error handling
handleLongCallFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a long call into a ProcessorSimulationTrap signal."
	|  callAddress failedInstruction|
	"grab the instruction at issue"
	failedInstruction := memoryArray unsignedLongAt: pc + 1 bigEndian: false.
	"Hmm. Perhaps we ought to test for an actual BLX here rather than assuming?"
	(self instructionIsBLX: failedInstruction)
				ifFalse:[ self halt: 'failed call type test'].
	"The memoryArray starts indexing from 1, whereas the pc is based on 0-indexing, therefore all access-offsets are one greater than expected" 
	"address, combined from prior four MOV/ORR instructions. See CogARMCompiler>concretizeLongCall"
	callAddress := (memoryArray byteAt: pc -3) 
						+ ((memoryArray byteAt: pc - 7) << 8) 
						+ ((memoryArray byteAt: pc - 11) << 16) 
						+ ((memoryArray byteAt: pc - 15) << 24).
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: callAddress signedIntToLong
			type: #call)
		signal