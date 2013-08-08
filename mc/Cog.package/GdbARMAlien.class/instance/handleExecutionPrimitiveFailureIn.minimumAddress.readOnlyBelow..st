error handling
handleExecutionPrimitiveFailureIn: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress "<Integer>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Handle an execution primitive failure.  Convert out-of-range call and absolute
	 memory read into register instructions into ProcessorSimulationTrap signals."
	"self printRegistersOn: Transcript"
	| pc |
	((pc := self pc) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[(self instructionTypeAt: pc in: memoryArray)
			caseOf: {
				[#Call] 			-> [^self handleCallFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#Jump] 		-> [^self handleJmpFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#MoveAwR]	-> [^self handleMoveAwRFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#MoveMbrR]	-> [^self handleMoveMbrRFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#MoveRAw]	-> [^self handleMoveRAwFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#MoveRMbr]	-> [^self handleMoveRMbrFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#Ret]			-> [^self handleRetFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].} 
			otherwise: [^self handleExecutionPrimitiveFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress]].
	((pc := self lr - 4) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[(self instructionTypeAt: pc in: memoryArray)
			caseOf: {
				[#Call] 		-> [^self handleCallFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#Jump] 	-> [^self handleJmpFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].
				[#Ret]		-> [^self handleRetFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress].} 
			otherwise: [^self handleExecutionPrimitiveFailureAt: pc in: memoryArray readOnlyBelow: minimumWritableAddress]].
	^self reportPrimitiveFailure