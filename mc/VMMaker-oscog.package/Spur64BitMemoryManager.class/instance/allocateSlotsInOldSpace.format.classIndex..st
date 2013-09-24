allocation
allocateSlotsInOldSpace: numSlots format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  The header
	 will have been filled-in but not the contents."
	| bytes chunk |
	bytes := self objectBytesForSlots: numSlots.
	chunk := self allocateOldSpaceChunkOfBytes: bytes.
	chunk ifNil:
		[^nil].
	numSlots >= self numSlotsMask ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
		[self longAt: chunk
			put: numSlots + (self numSlotsMask << self numSlotsFullShift).
		 self longAt: chunk + self baseHeaderSize
			put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex).
		 ^chunk + self baseHeaderSize].
	self longAt: chunk
		put: (self headerForSlots: numSlots format: formatField classIndex: classIndex).
	^chunk