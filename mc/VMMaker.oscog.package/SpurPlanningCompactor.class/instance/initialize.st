instance initialization
initialize
	biasForGC := true.
	savedFirstFieldsSpace := SpurContiguousObjStack new.
	savedFirstFieldsSpaceWasAllocated := false