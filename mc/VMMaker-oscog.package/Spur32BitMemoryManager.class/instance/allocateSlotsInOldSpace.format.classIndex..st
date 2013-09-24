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
		[self flag: #endianness.
		 self longAt: chunk put: numSlots.
		 self longAt: chunk + 4 put: self numSlotsMask << self numSlotsHalfShift.
		 self longLongAt: chunk + self baseHeaderSize
			put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex).
		 ^chunk + self baseHeaderSize].
	self longLongAt: chunk put: (self headerForSlots: numSlots format: formatField classIndex: classIndex).
	^chunk