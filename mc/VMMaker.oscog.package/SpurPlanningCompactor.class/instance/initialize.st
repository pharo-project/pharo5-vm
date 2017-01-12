instance initialization
initialize
	biasForGC := true.
	savedFirstFieldsSpace := SpurContiguousObjStack new.
	savedFirstFieldsSpaceNotInOldSpace := true