allocation
allocateSlotsInOldSpace: numSlots bytes: totalBytes format: formatField classIndex: classIndex
	"Answer the oop of a chunk of space in oldSpace with numSlots slots.  The header
	 will have been filled-in but not the contents.  If no memory is available answer nil."
	<var: #totalBytes type: #usqInt>
	^self subclassResponsibility