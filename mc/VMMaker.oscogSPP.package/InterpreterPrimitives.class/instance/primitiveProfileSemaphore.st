process primitives
primitiveProfileSemaphore
	"Primitive. Install the semaphore to be used for profiling, 
	or nil if no semaphore should be used.
	See also primitiveProfileStart."
	| sema |
	<export: true>
	self methodArgumentCount = 1 ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	sema := self stackValue: 0.
	(sema = objectMemory nilObject
	 or: [objectMemory isSemaphoreOop: sema]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	profileSemaphore := sema.
	profileProcess := profileMethod := objectMemory nilObject.
	self pop: 1