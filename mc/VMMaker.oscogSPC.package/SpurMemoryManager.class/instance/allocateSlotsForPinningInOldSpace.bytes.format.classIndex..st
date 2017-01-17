allocation
allocateSlotsForPinningInOldSpace: numSlots bytes: totalBytes format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  Try and
	 allocate in a segment that already includes pinned objects.  The header of the
	 result will have been filled-in but not the contents."
	<var: #totalBytes type: #usqInt>
	^self subclassResponsibility