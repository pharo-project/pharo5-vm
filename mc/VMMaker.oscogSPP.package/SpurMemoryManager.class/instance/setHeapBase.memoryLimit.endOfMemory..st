snapshot
setHeapBase: baseOfHeap memoryLimit: memLimit endOfMemory: memEnd
	"Set the dimensions of the heap, answering the start of oldSpace. edenBytes holds the desired ``size of eden''
	 which is actually the total size of new space minus the reserve.  edenBytes is then divided up between eden
	 and the two survivor spaces, where each survivor space is a scavengerDenominator (one seventh) of the total."
	"Transcript
		cr; nextPutAll: 'heapBase: '; print: baseOfHeap; nextPut: $/; nextPutAll: baseOfHeap hex;
		nextPutAll: ' memLimit '; print: memLimit; nextPut: $/; nextPutAll: memLimit hex;
		nextPutAll: ' memEnd '; print: memEnd; nextPut: $/; nextPutAll: memEnd hex; cr; flush."
	"This is more than a little counter-intuitive.  Eden must include interpreterAllocationReserveBytes."
	<inline: #never>
	| reserve |
	reserve := coInterpreter interpreterAllocationReserveBytes.
	newSpaceStart := baseOfHeap.
	newSpaceLimit := baseOfHeap + edenBytes + reserve.
	scavenger newSpaceStart: newSpaceStart
				newSpaceBytes: newSpaceLimit - newSpaceStart
				survivorBytes: newSpaceLimit - newSpaceStart - reserve // self scavengerDenominator.

	freeStart := scavenger eden start.
	pastSpaceStart := scavenger pastSpace start.

	oldSpaceStart := newSpaceLimit.
	freeOldSpaceStart := memEnd.
	endOfMemory := memLimit.

	^baseOfHeap