allocation
shorten: objOop toIndexableSize: indexableSize
	"Reduce the number of indexable fields in objOop, a pointer object, to nSlots. Convert the
	 unused residual to a free chunk. Without changes to numSlotsForShortening:toIndexableSize:
	 this only works for arrayFormat and longFormat objects.
	 Answer the number of bytes returned to free memory, which may be zero if no change
	 was possible."
	<inline: false>
	| numSlots bytesBefore delta copy freeChunk |
	self assert: (self oop: (self addressAfter: objOop) isLessThanOrEqualTo: endOfMemory).
	numSlots := self numSlotsForShortening: objOop toIndexableSize: indexableSize.
	numSlots = (self numSlotsOf: objOop) ifTrue:
		[^0].
	bytesBefore := self bytesInObject: objOop.
	delta := bytesBefore - (self objectBytesForSlots: numSlots).

	(delta > 0
	 and: [delta <= self allocationUnit]) ifTrue:
		[copy := self allocateSlots: numSlots
					format: (self formatOf: objOop)
					classIndex: (self classIndexOf: objOop).
		 copy ifNil: [self error: 'shorten:toIndexableSize: attempted to shorten to allocationUnit!'].
		 0 to: numSlots - 1 do:
			[:i|
			self storePointerUnchecked: i
				ofObject: copy
				withValue: (self fetchPointer: i ofObject: objOop)].
		 (self isRemembered: objOop) ifTrue:
			[scavenger remember: copy].
		 self forward: objOop to: copy.
		 ^0].

	(self hasOverflowHeader: objOop)
		ifTrue:
			[self rawOverflowSlotsOf: objOop put: numSlots.
			 numSlots < self numSlotsMask ifTrue:
				[delta := delta - self allocationUnit]]
		ifFalse:
			[self assert: numSlots < self numSlotsMask.
			 self rawNumSlotsOf: objOop put: numSlots].

	self assert: (self oop: (self addressAfter: objOop) + delta isLessThanOrEqualTo: endOfMemory).
	"Since the 32-bit system rounds objects up to 64-bits, loosing
	 a slot may not actually change the bytes occupied by the object."
	delta = 0 ifTrue:
		[^0].

	freeChunk := self initFreeChunkWithBytes: delta at: (self addressAfter: objOop).
	self assert: (self addressAfter: freeChunk) <= endOfMemory.
	(self isInOldSpace: objOop)
		ifTrue:
			[totalFreeOldSpace := totalFreeOldSpace + delta.
			 self addToFreeList: freeChunk bytes: delta]
		ifFalse:
			[self
				setClassIndexOf: freeChunk to: self wordSizeClassIndexPun;
				setFormatOf: freeChunk to: self firstLongFormat].
	^delta