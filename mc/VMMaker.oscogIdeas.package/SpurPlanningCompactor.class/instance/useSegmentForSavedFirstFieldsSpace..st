space management
useSegmentForSavedFirstFieldsSpace: spaceEstimate
	"Attempt to allocate a memory segment large enough to hold the savedFirstFieldsSpace.
	 Invoked when neither eden nor a large free chunk are found to be big enough for the job."
	| allocatedSize |
	<var: #segAddress type: #'void *'>
	(manager "sent to the manager so that the simulator can increase memory to simulate a new segment"
		sqAllocateMemorySegmentOfSize: spaceEstimate
		Above: (self firstGapOfSizeAtLeast: spaceEstimate)
		AllocatedSizeInto: (self cCode: [self addressOf: allocatedSize]
								inSmalltalk: [[:sz| allocatedSize := sz]])) ifNotNil:
		[:segAddress|
		 savedFirstFieldsSpace
			start: segAddress asUnsignedIntegerPtr;
			limit: segAddress asUnsignedIntegerPtr + allocatedSize.
		 savedFirstFieldsSpaceNotInOldSpace := true.
		 self assert: self savedFirstFieldsSpaceWasAllocated.
		 ^true].
	^false