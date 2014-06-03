free space
bytesLeft: includeSwapSpace
	"Answer the amount of available free space. If includeSwapSpace is true, include
	 possibly available swap space. If includeSwapSpace is false, include possibly available
	 physical memory. For a report on the largest free block currently availabe within
	 Squeak memory but not counting extra memory use #primBytesLeft."
	^totalFreeOldSpace
	+ (scavenger eden limit - freeStart)
	+ (scavenger pastSpace limit - pastSpaceStart)
	+ (scavenger futureSpace limit - scavenger futureSpace limit)
	- coInterpreter interpreterAllocationReserveBytes