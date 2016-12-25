space management
useSegmentForSavedFirstFieldsSpace: spaceEstimate
	"Attempt to allocate a memory segment large enough to hold the savedFirstFieldsSpace.
	 Invoked when neither eden nor a large free chunk are found to be big enough for the
	 job."
	| allocatedSize |
	(manager "sent to the manager so that the simulator can increase memory to simulate a new segment"
		sqAllocateMemorySegmentOfSize: spaceEstimate
		Above: (self firstGapOfSizeAtLeast: spaceEstimate)
		AllocatedSizeInto: (self cCode: [self addressOf: allocatedSize]
								inSmalltalk: [[:sz| allocatedSize := sz]])) ifNotNil:
		[:segAddress|
		 savedFirstFieldsSpaceWasAllocated := true.
		 savedFirstFieldsSpace
			start: segAddress;
			limit: segAddress + allocatedSize.
		 ^true].
	^false