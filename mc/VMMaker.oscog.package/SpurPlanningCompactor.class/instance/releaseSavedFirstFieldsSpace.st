space management
releaseSavedFirstFieldsSpace
	<inline: true>
	savedFirstFieldsSpaceWasAllocated ifTrue:
		[manager
			sqDeallocateMemorySegmentAt: savedFirstFieldsSpace start asVoidPointer
			OfSize: savedFirstFieldsSpace limit - savedFirstFieldsSpace start.
		 savedFirstFieldsSpaceWasAllocated := false]