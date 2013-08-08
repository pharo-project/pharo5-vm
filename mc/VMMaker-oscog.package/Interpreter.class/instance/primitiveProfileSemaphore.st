process primitives
primitiveProfileSemaphore
	"Primitive. Install the semaphore to be used for profiling, 
	or nil if no semaphore should be used.
	See also primitiveProfileStart."
	| sema |
	<export: true>
	self methodArgumentCount = 1 ifFalse:[^self success: false].
	sema := self stackValue: 0.
	sema == nilObj ifFalse:[
		(self fetchClassOf: sema) == (self splObj: ClassSemaphore) 
			ifFalse:[^self success: false]].
	profileSemaphore := sema.
	self pop: 1.