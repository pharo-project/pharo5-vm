allocation
allocateSlots: numSlots format: formatField classIndex: classIndex
	| numBytes newObj |
	"Object headers are 8 bytes in length if the slot size fits in the num slots field (max implies overflow),
	 16 bytes otherwise (num slots in preceeding word).
	 Objects always have at least one slot, for the forwarding pointer,
	 and are multiples of 8 bytes in length."
	numSlots >= self numSlotsMask
		ifTrue:
			[numSlots > 16rffffffff ifTrue:
				[^nil].
			 newObj := freeStart + self baseHeaderSize.
			 numBytes := (self baseHeaderSize + self baseHeaderSize) "double header"
						+ (numSlots * self bytesPerSlot)]
		ifFalse:
			[newObj := freeStart.
			 numBytes := self baseHeaderSize "single header"
						+ (numSlots < 1
							ifTrue: [self allocationUnit] "at least one slot for the forwarding pointer"
							ifFalse: [numSlots * self bytesPerSlot])].
	
	freeStart + numBytes > scavengeThreshold ifTrue:
		[needGCFlag ifFalse: [self scheduleScavenge].
		 freeStart + numBytes > scavenger eden limit ifTrue:
			[^self allocateSlotsInOldSpace: numSlots format: formatField classIndex: classIndex]].
	numSlots >= self numSlotsMask
		ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
			[self flag: #endianness.
			 self longAt: freeStart put: numSlots.
			 self longAt: freeStart + 4 put: self numSlotsMask << self numSlotsHalfShift.
			 self longLongAt: newObj put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex)]
		ifFalse:
			[self longLongAt: newObj put: (self headerForSlots: numSlots format: formatField classIndex: classIndex)].
	self assert: numBytes \\ self allocationUnit = 0.
	self assert: newObj \\ self allocationUnit = 0.
	freeStart := freeStart + numBytes.
	^newObj