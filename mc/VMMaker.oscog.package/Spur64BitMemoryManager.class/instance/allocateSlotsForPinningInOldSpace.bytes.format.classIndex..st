allocation
allocateSlotsForPinningInOldSpace: numSlots bytes: totalBytes format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  Try and
	 allocate in a segment that already includes pinned objects.  The header of the
	 result will have been filled-in but not the contents."
	<var: #totalBytes type: #usqInt>
	<inline: false>
	| chunk |
	chunk := self allocateOldSpaceChunkOfBytes: totalBytes
				   suchThat: [:f| (segmentManager segmentContainingObj: f) containsPinned].
	chunk ifNil:
		[chunk := self allocateOldSpaceChunkOfBytes: totalBytes.
		 chunk ifNil:
			[^nil].
		 (segmentManager segmentContainingObj: chunk) containsPinned: true].
	numSlots >= self numSlotsMask ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
		[self longAt: chunk
			put: numSlots + (self numSlotsMask << self numSlotsFullShift).
		 self longAt: chunk + self baseHeaderSize
			put: ((self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex)
					bitOr: 1 << self pinnedBitShift).
		 self checkFreeSpace: GCModeNewSpace.
		 ^chunk + self baseHeaderSize].
	self longAt: chunk
		put: ((self headerForSlots: numSlots format: formatField classIndex: classIndex)
				bitOr: 1 << self pinnedBitShift).
	self checkFreeSpace: GCModeNewSpace.
	^chunk