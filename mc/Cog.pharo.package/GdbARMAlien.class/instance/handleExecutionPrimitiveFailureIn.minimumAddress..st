error handling
handleExecutionPrimitiveFailureIn: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress "<Integer>"
	"Handle an execution primitive failure.  Convert out-of-range call and absolute
	 memory read into register instructions into ProcessorSimulationTrap signals."
	"self printRegistersOn: Transcript"
	| pc |
	self endCondition = 5 ifTrue:[self pc: self priorPc].
	((pc := self pc) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[(self instructionTypeAt: pc in: memoryArray)
			caseOf: {
				[#Call] 			-> [^self handleCallFailureAt: pc in: memoryArray].
				[#LongCall] 	-> [^self handleLongCallFailureAt: pc in: memoryArray].
				[#Jump] 		-> [^self handleJmpFailureAt: pc in: memoryArray].
				[#LongJump] 	-> [^self handleLongJmpFailureAt: pc in: memoryArray].
				[#MoveAwR]	-> [^self handleMoveAwRFailureAt: pc in: memoryArray].
				[#MoveMbrR]	-> [^self handleMoveMbrRFailureAt: pc in: memoryArray].
				[#MoveRAw]	-> [^self handleMoveRAwFailureAt: pc in: memoryArray].
				[#MoveRMbr]	-> [^self handleMoveRMbrFailureAt: pc in: memoryArray].
				[#Ret]			-> [^self handleRetFailureAt: pc in: memoryArray].} 
			otherwise: [^self handleExecutionPrimitiveFailureAt: pc in: memoryArray]].

	pc = 0 ifTrue:[self halt: 'pc should not be 0 at this point; simulator failure'].

	((pc := self lr - 4) between: minimumAddress and: memoryArray byteSize - 1) ifTrue:
		[(self instructionTypeAt: pc in: memoryArray)
			caseOf: {
				[#Call] 		-> [^self handleCallFailureAt: pc in: memoryArray].
				[#LongCall] -> [^self handleLongCallFailureAt: pc in: memoryArray].
				[#Jump] 	-> [^self handleJmpFailureAt: pc in: memoryArray].
				[#LongJump] 	-> [^self handleLongJmpFailureAt: pc in: memoryArray].
				[#Ret]		-> [^self handleRetFailureAt: pc in: memoryArray].} 
			otherwise: [^self handleExecutionPrimitiveFailureAt: pc in: memoryArray]].
	^self reportPrimitiveFailure