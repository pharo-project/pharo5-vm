allocation
allocateSlotsInOldSpace: numSlots bytes: totalBytes format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  The header
	 will have been filled-in but not the contents.  If no memory is available answer nil."
	<var: #totalBytes type: #usqInt>
	<inline: false>
	| chunk |
	chunk := self allocateOldSpaceChunkOfBytes: totalBytes.
	chunk ifNil:
		[^nil].
	numSlots >= self numSlotsMask ifTrue: "for header parsing we put a saturated slot count in the prepended overflow size word"
		[self flag: #endianness.
		 self longAt: chunk put: numSlots.
		 self longAt: chunk + 4 put: self numSlotsMask << self numSlotsHalfShift.
		 self long64At: chunk + self baseHeaderSize
			put: (self headerForSlots: self numSlotsMask format: formatField classIndex: classIndex).
		 self checkFreeSpace: GCModeNewSpace.
		 ^chunk + self baseHeaderSize].
	self long64At: chunk put: (self headerForSlots: numSlots format: formatField classIndex: classIndex).
	self checkFreeSpace: GCModeNewSpace.
	^chunk