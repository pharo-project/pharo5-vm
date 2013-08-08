I/O primitives
primitiveSetLogDirectory
	"Primitive. Set the VM's log directory"
	| stringOop sz |
	<export: true>
	stringOop := self stackTop.
	(objectMemory isBytes: stringOop) ifFalse:[^self success: false].
	sz := objectMemory byteSizeOf: stringOop.
	self ioSetLogDirectory: (objectMemory firstIndexableField: stringOop) OfSize: sz.
	self successful ifTrue:[self pop: self methodArgumentCount]