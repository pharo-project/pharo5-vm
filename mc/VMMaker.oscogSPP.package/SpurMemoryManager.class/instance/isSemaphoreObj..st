object testing
isSemaphoreObj: anObj
	^(self classIndexOf: anObj) = (self rawHashBitsOf: (self splObj: ClassSemaphore))