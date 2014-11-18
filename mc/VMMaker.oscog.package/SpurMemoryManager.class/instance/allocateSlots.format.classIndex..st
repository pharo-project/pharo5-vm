allocation
allocateSlots: numSlots format: formatField classIndex: classIndex
	"Allocate an object with numSlots space.  If there is room beneath scavengeThreshold
	 allocate in newSpace, otherwise alocate in oldSpace.  If there is not room in newSpace
	 and a scavenge is not already scheduled, schedule a scavenge."
	self subclassResponsibility