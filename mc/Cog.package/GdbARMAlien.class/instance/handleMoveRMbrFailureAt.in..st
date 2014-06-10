error handling
handleMoveRMbrFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
		"Convert an execution primitive failure for a byte register write into a ProcessorSimulationTrap signal."
	"MoveRMbr"
	| modrmByte |
	self halt.
	^(((modrmByte := memoryArray byteAt: pc + 2) bitAnd: 16rC0) = 16r80) "ModRegRegDisp32"
		ifTrue:
			[(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 6
					address: ((self perform: (#(eax ecx edx ebx esp ebp esi edi) at: (modrmByte bitAnd: 7) + 1))
							+ (memoryArray unsignedLongAt: pc + 3 bigEndian: false)
								bitAnd: 16rFFFFFFFF)
					type: #write
					accessor: (#(al cl dl bl ah ch dh bh) at: ((modrmByte >> 3 bitAnd: 7) + 1)))
				signal]
		ifFalse:
			[self reportPrimitiveFailure]