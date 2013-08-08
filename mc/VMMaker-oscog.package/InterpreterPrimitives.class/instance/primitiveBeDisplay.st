I/O primitives
primitiveBeDisplay
	"Record the system Display object in the specialObjectsTable."
	| rcvr |
	rcvr := self stackTop.
	self success: ((objectMemory isPointers: rcvr) and: [(objectMemory lengthOf: rcvr) >= 4]).
	self successful ifTrue: [objectMemory splObj: TheDisplay put: rcvr]