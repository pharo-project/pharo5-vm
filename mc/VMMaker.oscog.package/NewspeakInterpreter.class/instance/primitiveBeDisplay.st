I/O primitives
primitiveBeDisplay
	"Record the system Display object in the specialObjectsTable."
	| rcvr |
	rcvr := self stackTop.
	self success: ((self isPointers: rcvr) and: [(self lengthOf: rcvr) >= 4]).
	self successful ifTrue: [self storePointer: TheDisplay ofObject: specialObjectsOop withValue: rcvr]