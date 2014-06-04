snapshot
setHeapBase: baseOfHeap memoryLimit: memLimit endOfMemory: memEnd
	"Set the dimensions of the heap, answering the start of oldSpace."
	"Transcript
		cr; nextPutAll: 'heapBase: '; print: baseOfHeap; nextPut: $/; nextPutAll: baseOfHeap hex;
		nextPutAll: ' memLimit '; print: memLimit; nextPut: $/; nextPutAll: memLimit hex;
		nextPutAll: ' memEnd '; print: memEnd; nextPut: $/; nextPutAll: memEnd hex; cr; flush."
	"This is a little counter-intuitive.  Eden must include interpreterAllocationReserveBytes."
	newSpaceStart := baseOfHeap.
	newSpaceLimit := baseOfHeap
					 + self newSpaceBytes
					 + coInterpreter interpreterAllocationReserveBytes.
	scavenger
		newSpaceStart: newSpaceStart
		newSpaceBytes: newSpaceLimit - newSpaceStart
		edenBytes: newSpaceLimit - newSpaceStart
				   * (self scavengerDenominator - self numSurvivorSpaces) // self scavengerDenominator.
	freeStart := scavenger eden start.
	pastSpaceStart := scavenger pastSpace start.

	oldSpaceStart := newSpaceLimit.
	freeOldSpaceStart := memEnd.
	endOfMemory := memLimit.
	^baseOfHeap