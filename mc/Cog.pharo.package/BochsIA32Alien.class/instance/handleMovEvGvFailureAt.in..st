error handling
handleMovEvGvFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a register write into a ProcessorSimulationTrap signal."
	| modrmByte |
	^((modrmByte := memoryArray byteAt: pc + 2) bitAnd: 16rC7) = 16r5 "ModRegInd & disp32"
		ifTrue:
			[(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 6
					address: (memoryArray unsignedLongAt: pc + 3 bigEndian: false)
					type: #write
					accessor: (#(eax ecx edx ebx esp ebp esi edi) at: ((modrmByte >> 3 bitAnd: 7) + 1)))
				signal]
		ifFalse:
			[self reportPrimitiveFailure]