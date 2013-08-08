I/O primitives
primitiveInputSemaphore
	"Register the input semaphore. The argument is an index into the ExternalObjectsArray part of the specialObjectsArray and must have been allocated via 'Smalltalk registerExternalObject: the Semaphore' "
	| arg |
	arg := self stackTop.
	(self isIntegerObject: arg)
		ifTrue: ["If arg is integer, then condsider it as an index  into the external objects array and install it  as the new event semaphore"
			self ioSetInputSemaphore: (self integerValueOf: arg).
			self successful
				ifTrue: [self pop: 1].
			^ nil]