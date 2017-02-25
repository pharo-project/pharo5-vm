space management
updateSavedFirstFieldsSpaceIfNecessary
	"If savedFirstFieldsSpace is a free chunk then it may need to be repositioned if there is more than one pass."
	<inline: true>
	self savedFirstFieldsSpaceInFreeChunk ifTrue:
		[self useFreeChunkForSavedFirstFieldsSpace: manager findLargestFreeChunk].

	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop