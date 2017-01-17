interpreter access
isSemaphoreObj: anObj
	^(self fetchClassOfNonImm: anObj) = (self splObj: ClassSemaphore)