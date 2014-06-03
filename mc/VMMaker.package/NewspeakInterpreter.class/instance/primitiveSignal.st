process primitives
primitiveSignal
"synchromously signal the semaphore. This may change the active process as a result"
	| sema |
	sema := self stackTop.  "rcvr"
	self assertClassOf: sema is: (self splObj: ClassSemaphore).
	self successful ifTrue: [ self synchronousSignal: sema ].