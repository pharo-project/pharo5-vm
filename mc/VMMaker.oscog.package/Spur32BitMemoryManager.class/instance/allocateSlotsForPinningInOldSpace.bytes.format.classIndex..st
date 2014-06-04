allocation
allocateSlotsForPinningInOldSpace: numSlots bytes: totalBytes format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  Try and
	 allocate in a segment that already includes pinned objects.  The header of the
	 result will have been filled-in but not the contents."
	<inline: false>
	| chunk |
	chunk := self allocateOldSpaceChunkOfBytes: totalBytes
				   suchThat: [:f| (segmentManager segmentContainingObj: f) containsPinned].
	chunk ifNil:
		[chunk := self allocateOldSpaceChunkOfBytes: totalBytes.
		 chunk ifNotNil:
			[(segmentManager segmentContainingObj: chunk) containsPinned: true]].
	self checkFreeSpace.
	chunk ifNil:
		[^nil].
	numSlots >= self numSlotsMask ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
		[self flag: #endianness.
		 self longAt: chunk put: numSlots.
		 self longAt: chunk + 4 put: self numSlotsMask << self numSlotsHalfShift.
		 self long64At: chunk + self baseHeaderSize
			put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex).
		 ^chunk + self baseHeaderSize].
	self long64At: chunk put: (self headerForSlots: numSlots format: formatField classIndex: classIndex).
	^chunk