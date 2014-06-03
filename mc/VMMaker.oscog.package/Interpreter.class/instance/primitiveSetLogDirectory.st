I/O primitives
primitiveSetLogDirectory
	"Primitive. Set the VM's log directory"
	| stringOop sz |
	<export: true>
	stringOop := self stackTop.
	(self isBytes: stringOop) ifFalse:[^self success: false].
	sz := self byteSizeOf: stringOop.
	self ioSetLogDirectory: (self firstIndexableField: stringOop) OfSize: sz.
	successFlag ifTrue:[self pop: self methodArgumentCount]