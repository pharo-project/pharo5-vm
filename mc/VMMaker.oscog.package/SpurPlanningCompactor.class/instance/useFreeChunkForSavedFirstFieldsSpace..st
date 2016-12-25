space management
useFreeChunkForSavedFirstFieldsSpace: highestSuitableFreeBlock
	"Use the supplied free chunk to hold the savedFirstFieldsSpace.
	 Invoked when eden is found not to be big enough for the job."
	<inline: true>
	savedFirstFieldsSpace
		start: highestSuitableFreeBlock;
		limit: (manager addressAfter: highestSuitableFreeBlock)