I/O primitives
primitiveSetWindowLabel
	"Primitive. Set the OS window's label"
	| labelOop sz |
	<export: true>
	labelOop := self stackTop.
	(self isBytes: labelOop) ifFalse:[^self success: false].
	sz := self byteSizeOf: labelOop.
	self ioSetWindowLabel: (self firstIndexableField: labelOop) OfSize: sz.
	successFlag ifTrue:[self pop: self methodArgumentCount]