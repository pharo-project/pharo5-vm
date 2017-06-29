free space
bytesLeft: includeSwapSpace
	"Answer the amount of available free space. If includeSwapSpace is true, include
	 possibly available swap space. If includeSwapSpace is false, include possibly available
	 physical memory.  N.B. includeSwapSpace is ignored; answer total heap free space
	 minus the reserve available for flushing the tsack zone."
	^totalFreeOldSpace
	+ (scavenger eden limit - freeStart)
	+ (scavenger pastSpace limit - pastSpaceStart)
	+ (scavenger futureSpace limit - scavenger futureSpace limit)
	- coInterpreter interpreterAllocationReserveBytes