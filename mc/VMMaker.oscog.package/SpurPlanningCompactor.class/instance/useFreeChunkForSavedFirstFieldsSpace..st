space management
useFreeChunkForSavedFirstFieldsSpace: highestSuitableFreeBlock
	"Use the supplied free chunk to hold the savedFirstFieldsSpace. Invoked when
	 eden is found not to be big enough for the job. Avoid the first few fields so as
	 not to destroy the free chunk and there by confuse object enumeration."
	<inline: true>
	savedFirstFieldsSpace
		start: highestSuitableFreeBlock + (manager freeChunkLargerIndex * manager bytesPerOop);
		limit: (manager addressAfter: highestSuitableFreeBlock).
	savedFirstFieldsSpaceNotInOldSpace := false.
	self deny: self savedFirstFieldsSpaceWasAllocated