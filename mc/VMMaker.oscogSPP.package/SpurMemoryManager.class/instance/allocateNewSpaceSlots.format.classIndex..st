allocation
allocateNewSpaceSlots: numSlots format: formatField classIndex: classIndex
	"Allocate an object with numSlots in newSpace.  This is for the `ee' execution engine allocations,
	 and must be satisfied.  If no memory is available, abort.  If the allocation pushes freeStart past
	 scavengeThreshold and a scavenge is not already scheduled, schedule a scavenge."
	| numBytes newObj |
	"Object headers are 8 bytes in length if the slot size fits in the num slots field (max implies overflow),
	 16 bytes otherwise (num slots in preceding word).
	 Objects always have at least one slot, for the forwarding pointer,
	 and are multiples of 8 bytes in length."
	numSlots >= self numSlotsMask
		ifTrue:
			[(self wordSize >= 8 and: [numSlots > 16rffffffff]) ifTrue:
				[^nil]. "overflow size must fit in 32-bits"
			 newObj := freeStart + self baseHeaderSize.
			 numBytes := self largeObjectBytesForSlots: numSlots]
		ifFalse:
			[newObj := freeStart.
			 numBytes := self smallObjectBytesForSlots: numSlots].
	
	freeStart + numBytes > scavengeThreshold ifTrue:
		[needGCFlag ifFalse: [self scheduleScavenge].
		 freeStart + numBytes > scavenger eden limit ifTrue:
			[self error: 'no room in eden for allocateNewSpaceSlots:format:classIndex:'.
			 ^0]].
	numSlots >= self numSlotsMask
		ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
			[self flag: #endianness.
			 self longAt: freeStart put: numSlots.
			 self longAt: freeStart + 4 put: self numSlotsMask << self numSlotsHalfShift.
			 self long64At: newObj put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex)]
		ifFalse:
			[self long64At: newObj put: (self headerForSlots: numSlots format: formatField classIndex: classIndex)].
	self assert: numBytes \\ self allocationUnit = 0.
	self assert: newObj \\ self allocationUnit = 0.
	freeStart := freeStart + numBytes.
	^newObj