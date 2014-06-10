allocation
allocateSmallNewSpaceSlots: numSlots format: formatField classIndex: classIndex
	"Allocate an object with numSlots in newSpace, where numSlots is known to be small.
	 This is for the `ee' execution engine allocations, and must be satisfied.  If no memory
	 is available, abort.  If the allocation pushes freeStart past scavengeThreshold and a
	 scavenge is not already scheduled, schedule a scavenge."
	<inline: true>
	| numBytes newObj |
	self assert: numSlots < self numSlotsMask.
	newObj := freeStart.
	numBytes := self smallObjectBytesForSlots: numSlots.
	self assert: numBytes \\ self allocationUnit = 0.
	self assert: newObj \\ self allocationUnit = 0.
	freeStart + numBytes > scavengeThreshold ifTrue:
		[needGCFlag ifFalse: [self scheduleScavenge].
		 freeStart + numBytes > scavenger eden limit ifTrue:
			[self error: 'no room in eden for allocateSmallNewSpaceSlots:format:classIndex:'.
			 ^0]].
	self long64At: newObj put: (self headerForSlots: numSlots format: formatField classIndex: classIndex).
	freeStart := freeStart + numBytes.
	^newObj