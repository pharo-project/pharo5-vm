interpreter access
isSemaphoreOop: anOop
	^(self isNonImmediate: anOop)
	 and: [self isSemaphoreObj: anOop]