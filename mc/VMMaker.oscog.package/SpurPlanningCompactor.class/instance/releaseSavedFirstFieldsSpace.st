space management
releaseSavedFirstFieldsSpace
	<inline: true>
	self savedFirstFieldsSpaceWasAllocated ifTrue:
		[manager
			sqDeallocateMemorySegmentAt: savedFirstFieldsSpace start asVoidPointer
			OfSize: savedFirstFieldsSpace limit - savedFirstFieldsSpace start]