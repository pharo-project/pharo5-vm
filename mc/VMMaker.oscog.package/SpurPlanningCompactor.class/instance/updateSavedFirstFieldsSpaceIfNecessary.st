space management
updateSavedFirstFieldsSpaceIfNecessary
	"If savedFirstFieldsSpace is a free chunk then it may need to be repositioned if there is more than one pass."
	<inline: true>
	(self savedFirstFieldsSpaceInFreeChunk
	 and: [savedFirstFieldsSpace start < lastMobileObject]) ifTrue:
		[(self findHighestSuitableFreeBlock: savedFirstFieldsSpace limit - savedFirstFieldsSpace start)
			ifNotNil:
				[:largestFreeChunk|
				 self useFreeChunkForSavedFirstFieldsSpace: largestFreeChunk]
			ifNil:
				[self useEdenForSavedFirstFieldsSpace]].

	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop