I/O primitives
primitiveSetWindowLabel
	"Primitive. Set the OS window's label"
	| labelOop sz |
	<export: true>
	labelOop := self stackTop.
	(objectMemory isBytes: labelOop) ifFalse:[^self success: false].
	sz := objectMemory byteSizeOf: labelOop.
	self ioSetWindowLabel: (objectMemory firstIndexableField: labelOop) OfSize: sz.
	self successful ifTrue:[self pop: self methodArgumentCount]