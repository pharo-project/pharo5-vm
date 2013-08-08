error handling
handleCallFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a call into a ProcessorSimulationTrap signal."
	|  relativeJump callAddress |
	((memoryArray byteAt: pc + 4) bitAnd: 16rF) = 16rB "BL opcode"
		ifTrue: ["short jump via BL, therefore we have a 24bit signed integer offset"
			relativeJump := (memoryArray unsignedLongAt: pc + 1 bigEndian: false) bitAnd: 16r00FFFFFF.
			relativeJump := (relativeJump bitAt: 24) = 1 
									ifTrue: [((relativeJump bitOr: 16r3F000000) << 2) signedIntFromLong]
									ifFalse: [relativeJump << 2].
			callAddress := (pc + 8 + relativeJump)]
		
		ifFalse: ["long jump using RISCTempReg"
			"The memoryArray starts indexing from 1, whereas the pc is based on 0-indexing, therefore all access-offsets are one greater than expected"
			callAddress := (memoryArray byteAt: pc + 4) 
								+ ((memoryArray byteAt: pc - 4) << 24) 
								+ ((memoryArray byteAt: pc - 8) << 16) 
								+ ((memoryArray byteAt: pc - 12) << 8)].
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: callAddress signedIntToLong
			type: #call)
		signal