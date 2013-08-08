process primitives
primitiveProfileSemaphore
	"Primitive. Install the semaphore to be used for profiling, 
	or nil if no semaphore should be used.
	See also primitiveProfileStart."
	| sema |
	<export: true>
	self methodArgumentCount = 1 ifFalse:[^self success: false].
	sema := self stackValue: 0.
	sema = objectMemory nilObject ifFalse:[
		(objectMemory fetchClassOf: sema) = (objectMemory splObj: ClassSemaphore) 
			ifFalse:[^self success: false]].
	profileSemaphore := sema.
	profileProcess := profileMethod := objectMemory nilObject.
	self pop: 1.