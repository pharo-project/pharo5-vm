allocation
shorten: objOop toIndexableSize: indexableSize
	"Reduce the number of indexable fields in objOop, a pointer object, to nSlots. Convert the
	 unused residual to a free chunk. Word and byte indexable objects are not changed.
	 Answer the number of bytes returned to free memory, which may be zero if no change
	 was possible."
	<inline: false>
	| numSlots bytesBefore bytesAfter |
	(self formatOf: objOop) caseOf:
		{ [self arrayFormat]	->	[numSlots := indexableSize] }.
	bytesBefore := self bytesInObject: objOop.
	(self hasOverflowHeader: objOop)
		ifTrue: [self rawOverflowSlotsOf: objOop put: numSlots]
		ifFalse:
			[self assert: numSlots < self numSlotsMask.
			 self rawNumSlotsOf: objOop put: numSlots].
	bytesAfter := self bytesInObject: objOop.
	self freeChunkWithBytes: bytesAfter - bytesBefore at: (self addressAfter: objOop).
	^bytesAfter - bytesBefore