error handling
handleMovGvEbFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a register load into a ProcessorSimulationTrap signal."
	| modrmByte mode srcIsSP srcVal dst offset |
	modrmByte := memoryArray byteAt: pc + 3.
	mode := modrmByte >> 6 bitAnd: 3.
	dst := #(eax: ecx: edx: ebx: esp: ebp: esi: edi:) at: ((modrmByte >> 3 bitAnd: 7) + 1).
	mode = 0 ifTrue: "ModRegInd"
		[offset := memoryArray unsignedLongAt: pc + 4. "1-relative"
		 ^(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 7
					address: offset
					type: #read
					accessor: dst)
				signal].
	srcIsSP := (modrmByte bitAnd: 7) = 4.
	srcVal := self perform: (#(eax ecx edx ebx esp ebp esi edi) at: (modrmByte bitAnd: 7) + 1).
	mode = 1 ifTrue: "ModRegRegDisp8"
		[offset := memoryArray byteAt: pc + (srcIsSP ifTrue: [5] ifFalse: [4]). "1-relative"
		 offset > 127 ifTrue: [offset := offset - 256].
		 ^(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + (srcIsSP ifTrue: [5] ifFalse: [4])
					address: (srcVal + offset bitAnd: 16rFFFFFFFF)
					type: #read
					accessor: dst)
				signal].
	mode = 2 ifTrue: "ModRegRegDisp32"
		[offset := memoryArray unsignedLongAt: pc + (srcIsSP ifTrue: [5] ifFalse: [4]). "1-relative"
		 ^(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + (srcIsSP ifTrue: [8] ifFalse: [7])
					address: (srcVal + offset bitAnd: 16rFFFFFFFF)
					type: #read
					accessor: dst)
				signal].
	^self reportPrimitiveFailure