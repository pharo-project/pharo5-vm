object testing
isSemaphoreOop: anOop
	^(self isNonImmediate: anOop)
	 and: [self isSemaphoreObj: anOop]