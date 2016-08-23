I/O primitives
primitiveInputSemaphore
	"Register the input semaphore. If the argument is not a 
	Semaphore, unregister the current input semaphore."
	| arg |
	arg := self stackTop.
	(objectMemory isIntegerObject: arg) ifTrue:
		["If arg is integer, then use it as an index 
		  into the external objects array and install it 
		  as the new event semaphore"
		 self ioSetInputSemaphore: (objectMemory integerValueOf: arg).
		 self successful ifTrue:
			[self pop: 1].
		 ^nil].

	"old code for compatibility"
	TheInputSemaphore = nil ifTrue:
		[^self primitiveFail].
	(arg = objectMemory nilObject
	 or: [objectMemory isSemaphoreOop: arg])
		ifTrue:
			[objectMemory splObj: TheInputSemaphore put: arg.
			 self pop: 1]
		ifFalse:
			[self primitiveFailFor: PrimErrBadArgument]