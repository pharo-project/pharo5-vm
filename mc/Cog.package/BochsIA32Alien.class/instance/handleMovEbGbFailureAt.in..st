error handling
handleMovEbGbFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a byte register write into a ProcessorSimulationTrap signal."
	| modrmByte address |
	modrmByte := memoryArray byteAt: pc + 2.
	(modrmByte bitAnd: 7) ~= 4 ifTrue: "MoveRMbr with r = ESP requires an SIB byte"
		[address := (modrmByte bitAnd: 16rC0)
					caseOf: {
						[0 "ModRegInd"]
						->	[memoryArray unsignedLongAt: pc + 3 bigEndian: false].
						[16r80 "ModRegRegDisp32"]
						->	[(self perform: (#(eax ecx edx ebx esp ebp esi edi) at: (modrmByte bitAnd: 7) + 1))
								+ (memoryArray unsignedLongAt: pc + 3 bigEndian: false)
								bitAnd: 16rFFFFFFFF] }
					otherwise: [^self reportPrimitiveFailure].
		^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 6
				address: address
				type: #write
				accessor: (#(al cl dl bl ah ch dh bh) at: ((modrmByte >> 3 bitAnd: 7) + 1)))
			signal].
	^self reportPrimitiveFailure