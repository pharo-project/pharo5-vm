free space
freeSmallObject: objOop
	"Free a small object.  The wrinkle here is that we don't tolerate a zero-slot
	 count in a free object so that the (self longLongAt: objOop) ~= 0 assert in
	 isEnumerableObject: isn't triggered."
		 
	| headerNumSlots bytes index |
	headerNumSlots := self rawNumSlotsOf: objOop.
	headerNumSlots = 0
		ifTrue:
			[self setRawNumSlotsOf: objOop to: 1.
			 index := self baseHeaderSize + self allocationUnit / self allocationUnit]
		ifFalse:
			[bytes := self bytesInObject: objOop.
			 index := bytes / self allocationUnit.
			 self assert: index < self numFreeLists].
	self setFree: objOop. 
	self storePointer: self freeChunkNextIndex ofFreeChunk: objOop withValue: (freeLists at: index).
	freeLists at: index put: objOop