allocation
shorten: objOop toIndexableSize: indexableSize
	"Reduce the number of indexable fields in objOop, a pointer object, to nSlots. Convert the
	 unused residual to a free chunk. Without changes to numSlotsForShortening:toIndexableSize:
	 this only works for arrayFormat and longFormat objects.
	 Answer the number of bytes returned to free memory, which may be zero if no change
	 was possible."
	<inline: false>
	| numSlots bytesBefore delta freeChunk |
	numSlots := self numSlotsForShortening: objOop toIndexableSize: indexableSize.
	numSlots = (self numSlotsOf: objOop) ifTrue:
		[^0].
	bytesBefore := self bytesInObject: objOop.
	(self hasOverflowHeader: objOop)
		ifTrue: [self rawOverflowSlotsOf: objOop put: numSlots]
		ifFalse:
			[self assert: numSlots < self numSlotsMask.
			 self rawNumSlotsOf: objOop put: numSlots].
	delta := bytesBefore - (self bytesInObject: objOop).
	"We have options.
		1. we can clone the object and forward to the clone.
		2. if the following object has a short header we can given it a large header."
	self flag: 'deal with it, dude'.
	delta <= self allocationUnit ifTrue:
		[self error: 'shorten:toIndexableSize: attempted to shorten to allocationUnit!'].
	freeChunk := self initFreeChunkWithBytes: delta at: (self addressAfter: objOop).
	(self isInOldSpace: objOop)
		ifTrue:
			[totalFreeOldSpace := totalFreeOldSpace + delta.
			 self addToFreeList: freeChunk bytes: delta]
		ifFalse:
			[self
				setClassIndexOf: freeChunk to: self wordSizeClassIndexPun;
				setFormatOf: freeChunk to: self firstLongFormat].
	^delta